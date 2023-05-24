Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5521D70ED90
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 08:05:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1hcQ-0002hY-8x; Wed, 24 May 2023 02:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1q1hc3-0002gg-OH
 for qemu-devel@nongnu.org; Wed, 24 May 2023 02:04:43 -0400
Received: from mailout12.t-online.de ([194.25.134.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1q1hc1-0001jy-Dw
 for qemu-devel@nongnu.org; Wed, 24 May 2023 02:04:43 -0400
Received: from fwd82.dcpf.telekom.de (fwd82.aul.t-online.de [10.223.144.108])
 by mailout12.t-online.de (Postfix) with SMTP id 850BB215BA;
 Wed, 24 May 2023 08:04:35 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.24.239]) by fwd82.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1q1hbs-1CicwT0; Wed, 24 May 2023 08:04:32 +0200
Message-ID: <2602a029-295d-2d07-7e65-ba242386c97e@t-online.de>
Date: Wed, 24 May 2023 08:04:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] meson: move -no-pie from linker to compiler
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, richard.henderson@linaro.org
References: <20230523073029.19549-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
In-Reply-To: <20230523073029.19549-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1684908272-63FE59E6-E22D847C/0/0 CLEAN NORMAL
X-TOI-MSGID: 28426d3c-9d21-4bdb-8415-eed8ced7a108
Received-SPF: none client-ip=194.25.134.22; envelope-from=vr_qemu@t-online.de;
 helo=mailout12.t-online.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Am 23.05.23 um 09:30 schrieb Paolo Bonzini:
> The large comment in the patch says it all; the -no-pie flag is broken and
> this is why it was not included in QEMU_LDFLAGS before commit a988b4c5614
> ("build: move remaining compiler flag tests to meson", 2023-05-18).  And
> some distros made things even worse, so we have to add it to the compiler
> command line.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1664
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 0a5cdefd4d3d..20accae99281 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -265,12 +265,21 @@ endif
>   
>   # Meson currently only handles pie as a boolean for now, so if the user
>   # has explicitly disabled PIE we need to extend our cflags.
> +#
> +# -no-pie is supposedly a linker flag that has no effect on the compiler
> +# command line, but some distros, that didn't quite know what they were
> +# doing, made local changes to gcc's specs file that turned it into
> +# a compiler command-line flag.
> +#
> +# What about linker flags?  For a static build, no PIE is implied by -static
> +# which we added above (and if it's not because of the same specs patching,
> +# there's nothing we can do: compilation will fail, report a bug to your
> +# distro and do not use --disable-pie in the meanwhile).  For dynamic linking,
> +# instead, we can't add -no-pie because it overrides -shared: the linker then
> +# tries to build an executable instead of a shared library and fails.  So
> +# don't add -no-pie anywhere and cross fingers. :(
>   if not get_option('b_pie')
> -  qemu_common_flags += cc.get_supported_arguments('-fno-pie')
> -  if not get_option('prefer_static')
> -    # No PIE is implied by -static which we added above.
> -    qemu_ldflags += cc.get_supported_link_arguments('-no-pie')
> -  endif
> +  qemu_common_flags += cc.get_supported_arguments('-fno-pie', '-no-pie')
>   endif
>   
>   if not get_option('stack_protector').disabled()

I tested that QEMU builds on Windows with MSYS2 mingw64.

One unrelated note: The DLL loader doesn't find the libslirp-0.dll when 
QEMU was built with libslirp from the subprojects folder and started 
from the build folder. It's necessary to copy this library to a folder 
in the DLL search path.

Tested-by: Volker Rümelin <vr_qemu@t-online.de>

