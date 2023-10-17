Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D977CC58C
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:06:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qski9-0005eP-DH; Tue, 17 Oct 2023 10:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qskhx-0005PP-T7
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:06:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qskhu-0001JC-Iz
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:06:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D12231F88C;
 Tue, 17 Oct 2023 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697551558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TWaZuJ2tdxQxhiVbYORHxAo9YzORkhIFHVfTIWgUZws=;
 b=ALSPw8yTyTOOodYOlnPGrwLC6D8WhuCHdN7nagVMQ6gIJpnxeDUpfA8bdHFulX9sq6Z4U0
 q/eHX5p6IM9WbWYKqRxuwQYy2iTUKVmp6IlpzArwbUwqR4M+bcnEnf4CMJZ4t7/1k5oKCC
 JrEuDAVXwrvqY6OZS7LD5ToXzoLQY+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697551558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TWaZuJ2tdxQxhiVbYORHxAo9YzORkhIFHVfTIWgUZws=;
 b=ocGBXliD0EykEkB3nMUsIUsUd51Ly8ZqI/h4t+ExTFfo0Mg75U3rVKpkQ0BmSJUyrvq52t
 EgBt0EvUaRqVN0BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 634D713584;
 Tue, 17 Oct 2023 14:05:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TqgfDMaULmU6CwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 17 Oct 2023 14:05:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Alistair Francis
 <alistair.francis@wdc.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Yanan Wang
 <wangyanan55@huawei.com>
Subject: Re: [PULL 19/25] gdbstub: Replace gdb_regs with an array
In-Reply-To: <20231011103329.670525-20-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
 <20231011103329.670525-20-alex.bennee@linaro.org>
Date: Tue, 17 Oct 2023 11:05:56 -0300
Message-ID: <87ttqpwdh7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -5.60
X-Spamd-Result: default: False [-5.60 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_CC(0.00)[daynix.com,wdc.com,linaro.org,habkost.net,gmail.com,huawei.com];
 BAYES_HAM(-3.00)[99.99%]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[9];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>
> An array is a more appropriate data structure than a list for gdb_regs
> since it is initialized only with append operation and read-only after
> initialization.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Message-Id: <20230912224107.29669-13-akihiko.odaki@daynix.com>
> [AJB: fixed a checkpatch violation]
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20231009164104.369749-20-alex.bennee@linaro.org>
>
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 7b8347ed5a..3968369554 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -502,7 +502,7 @@ struct CPUState {
>=20=20
>      CPUJumpCache *tb_jmp_cache;
>=20=20
> -    struct GDBRegisterState *gdb_regs;
> +    GArray *gdb_regs;
>      int gdb_num_regs;
>      int gdb_num_g_regs;
>      QTAILQ_ENTRY(CPUState) node;
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 62608a5389..b1532118d1 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -51,7 +51,6 @@ typedef struct GDBRegisterState {
>      gdb_get_reg_cb get_reg;
>      gdb_set_reg_cb set_reg;
>      const char *xml;
> -    struct GDBRegisterState *next;
>  } GDBRegisterState;
>=20=20
>  GDBState gdbserver_state;
> @@ -386,7 +385,8 @@ static const char *get_feature_xml(const char *p, con=
st char **newp,
>                  xml,
>                  g_markup_printf_escaped("<xi:include href=3D\"%s\"/>",
>                                          cc->gdb_core_xml_file));
> -            for (r =3D cpu->gdb_regs; r; r =3D r->next) {
> +            for (guint i =3D 0; i < cpu->gdb_regs->len; i++) {

It seems we can reach here before having initialized gdb_regs at
gdb_register_coprocessor():

Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x0000555555e5310b in get_feature_xml (p=3D0x555556a99118
<gdbserver_state+56> "target.xml:0,ffb", newp=3D0x7fffffffc6b0,
process=3D0x555557a21dd0) at ../gdbstub/gdbstub.c:388

(gdb) p/x cpu->gdb_regs
$1 =3D 0x0


Using:
qemu-system-x86 ... -s -s

just connect GDB and it crashes.

