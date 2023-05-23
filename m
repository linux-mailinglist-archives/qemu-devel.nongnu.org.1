Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D37070D376
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 07:57:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1L1F-0005o0-ML; Tue, 23 May 2023 01:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1q1L1D-0005ns-Kh
 for qemu-devel@nongnu.org; Tue, 23 May 2023 01:57:11 -0400
Received: from mailout02.t-online.de ([194.25.134.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1q1L1B-0001IX-Ak
 for qemu-devel@nongnu.org; Tue, 23 May 2023 01:57:11 -0400
Received: from fwd76.dcpf.telekom.de (fwd76.aul.t-online.de [10.223.144.102])
 by mailout02.t-online.de (Postfix) with SMTP id 3787829AFD;
 Tue, 23 May 2023 07:57:03 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.24.239]) by fwd76.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1q1L14-1RcIDp0; Tue, 23 May 2023 07:57:02 +0200
Message-ID: <4571c74f-e401-d62c-995a-10bacd9fb417@t-online.de>
Date: Tue, 23 May 2023 07:57:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] meson: remove -no-pie linker flag
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
References: <20230522080816.66320-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
In-Reply-To: <20230522080816.66320-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1684821422-16FFE3A1-387615E9/0/0 CLEAN NORMAL
X-TOI-MSGID: 53bf01d3-9af0-4b3f-b64b-d04b07ee056c
Received-SPF: none client-ip=194.25.134.17; envelope-from=vr_qemu@t-online.de;
 helo=mailout02.t-online.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
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

Am 22.05.23 um 10:08 schrieb Paolo Bonzini:
> The large comment in the patch says it all; the -no-pie flag is broken and
> this is why it was not included in QEMU_LDFLAGS before commit a988b4c5614
> ("build: move remaining compiler flag tests to meson", 2023-05-18).
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1664
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 0a5cdefd4d3d..6733b2917081 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -267,10 +267,15 @@ endif
>   # has explicitly disabled PIE we need to extend our cflags.
>   if not get_option('b_pie')
>     qemu_common_flags += cc.get_supported_arguments('-fno-pie')
> -  if not get_option('prefer_static')
> -    # No PIE is implied by -static which we added above.
> -    qemu_ldflags += cc.get_supported_link_arguments('-no-pie')
> -  endif
> +  # What about linker flags?  For a static build, no PIE is implied by -static
> +  # which we added above.  For dynamic linking, adding -no-pie is messy because
> +  # it overrides -shared: the linker then wants to build an executable instead
> +  # of a shared library and the build fails.  Before moving this code to Meson,
> +  # we went through a dozen different commits affecting the usage of -no-pie,
> +  # ultimately settling for a completely broken one that added -no-pie to the
> +  # compiler flags together with -fno-pie... except that -no-pie is a linker
> +  # flag that has no effect on the compiler command line.  So, don't add
> +  # -no-pie anywhere and cross fingers.
>   endif
>   
>   if not get_option('stack_protector').disabled()

QEMU builds again on Windows with MSYS2 mingw64.

I also tried to build QEMU on Windows with libslirp from the subproject 
folder. The issue reported in 
https://gitlab.com/qemu-project/qemu/-/issues/1664 is fixed, but it now 
fails with a different error. This is a libslirp bug. See 
https://gitlab.freedesktop.org/slirp/libslirp/-/issues/68. The revision 
in subprojects/slirp.wrap should be at least 
fc5eaaf6f68d5cff76468c63984c33c4fb51506d.

Building QEMU on my Linux system works fine.

Tested-by: Volker Rümelin <vr_qemu@t-online.de>

