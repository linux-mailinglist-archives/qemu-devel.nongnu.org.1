Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8960282888D
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 15:54:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNDUt-0002fj-4z; Tue, 09 Jan 2024 09:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNDUd-0002Y3-Ed
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:54:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNDUb-0005Pz-F5
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704812052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qT5StO/GePljQeQo4FtH1LtnBaFd+lBt2tcpU1tcwnI=;
 b=UKI8FZ351II4AIIzb/jLF34uc9qhfL0TLptiCgO2EHhqZs8BpswIPWd3+i3cjhjX1ovy3A
 ve6P0rxHNU/6D2dfm4tqn3Y7UzNg8kZB8InfZp/cWiu1GjoODi/S6hzqIByANUuyweXM+3
 6zrt/hTFNG6JsfWkbMZ6hdeMVVnUY1Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-veKShO4vMj2rFB8sK_uupQ-1; Tue, 09 Jan 2024 09:54:09 -0500
X-MC-Unique: veKShO4vMj2rFB8sK_uupQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 00ED983DDE5;
 Tue,  9 Jan 2024 14:54:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA79F2026D6F;
 Tue,  9 Jan 2024 14:54:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BA27421E680D; Tue,  9 Jan 2024 15:54:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 1/2] meson: mitigate against ROP exploits with
 -fzero-call-used-regs
In-Reply-To: <20240103123414.2401208-2-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 3 Jan 2024 12:34:13
 +0000")
References: <20240103123414.2401208-1-berrange@redhat.com>
 <20240103123414.2401208-2-berrange@redhat.com>
Date: Tue, 09 Jan 2024 15:54:07 +0100
Message-ID: <87bk9ulfqo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> To quote wikipedia:
>
>   "Return-oriented programming (ROP) is a computer security exploit
>    technique that allows an attacker to execute code in the presence
>    of security defenses such as executable space protection and code
>    signing.
>
>    In this technique, an attacker gains control of the call stack to
>    hijack program control flow and then executes carefully chosen
>    machine instruction sequences that are already present in the
>    machine's memory, called "gadgets". Each gadget typically ends in
>    a return instruction and is located in a subroutine within the
>    existing program and/or shared library code. Chained together,
>    these gadgets allow an attacker to perform arbitrary operations
>    on a machine employing defenses that thwart simpler attacks."
>
> QEMU is by no means perfect with an ever growing set of CVEs from
> flawed hardware device emulation, which could potentially be
> exploited using ROP techniques.
>
> Since GCC 11 there has been a compiler option that can mitigate
> against this exploit technique:
>
>     -fzero-call-user-regs
>
> To understand it refer to these two resources:
>
>    https://www.jerkeby.se/newsletter/posts/rop-reduction-zero-call-user-r=
egs/
>    https://gcc.gnu.org/pipermail/gcc-patches/2020-August/552262.html
>
> I used two programs to scan qemu-system-x86_64 for ROP gadgets:
>
>   https://github.com/0vercl0k/rp
>   https://github.com/JonathanSalwan/ROPgadget
>
> When asked to find 8 byte gadgets, the 'rp' tool reports:
>
>   A total of 440278 gadgets found.
>   You decided to keep only the unique ones, 156143 unique gadgets found.
>
> While the ROPgadget tool reports:
>
>   Unique gadgets found: 353122
>
> With the --ropchain argument, the latter attempts to use the found
> gadgets to product a chain that can execute arbitrary syscalls. With
> current QEMU it succeeds in this task, which is an undesirable
> situation.
>
> With QEMU modified to use -fzero-call-user-regs=3Dused-gpr the 'rp' tool
> reports
>
>   A total of 528991 gadgets found.
>   You decided to keep only the unique ones, 121128 unique gadgets found.
>
> This is 22% fewer unique gadgets
>
> While the ROPgadget tool reports:
>
>   Unique gadgets found: 328605
>
> This is 7% fewer unique gadgets. Crucially though, despite this more
> modest reduction, the ROPgadget tool is no longer able to identify a
> chain of gadgets for executing arbitrary syscalls. It fails at the
> very first step, unable to find gadgets for populating registers for
> a future syscall. Having said that, more advanced tools do still
> manage to put together a viable ROP chain.
>
> Also this only takes into account QEMU code. QEMU links to many 3rd
> party shared libraries and ideally all of them would be compiled with
> this same hardening. That becomes a distro policy question though.
>
> In terms of performance impact, TCG was used as an evaluation test
> case. We're not interested in protecting TCG since it isn't designed
> to provide a security barrier, but it is performance sensitive code,
> so useful as a guide to how other areas of QEMU might be impacted.
> With the -fzero-call-user-regs=3Dused-gpr argument present, using the
> real world test of booting a linux kernel and having init immediately
> poweroff, there is a ~1% slow down in performance under TCG. The QEMU
> binary size also grows by approximately 1%.
>
> By comparison, using the more aggressive -fzero-call-user-regs=3Dall,
> results in a slowdown of over 25% in TCG, which is clearly not an
> acceptable impact, and a binary size increase of 5%.
>
> Considering that 'used-gpr' succesfully stopped ROPgadget assembling
> a chain, this more targetted protection is a justifiable hardening
> / performance tradeoff.

Have you also considered 'used-arg'?

> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  meson.build | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 6c77d9687d..eaa20d241d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -433,6 +433,17 @@ if get_option('fuzzing')
>    endif
>  endif
>=20=20
> +# Check further flags that make QEMU more robust against malicious parti=
es
> +
> +hardening_flags =3D [
> +    # Zero out registers used during a function call
> +    # upon its return. This makes it harder to assemble
> +    # ROP gadgets into something usable
> +    '-fzero-call-used-regs=3Dused-gpr',
> +]
> +
> +qemu_common_flags +=3D cc.get_supported_arguments(hardening_flags)
> +
>  add_global_arguments(qemu_common_flags, native: false, language: all_lan=
guages)
>  add_global_link_arguments(qemu_ldflags, native: false, language: all_lan=
guages)


