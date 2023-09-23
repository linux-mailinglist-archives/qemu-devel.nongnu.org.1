Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B155B7AC17C
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 13:50:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qk18T-0000Zk-M0; Sat, 23 Sep 2023 07:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qk18R-0000ZR-GY
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 07:49:19 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qk18P-00031T-FZ
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 07:49:19 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1C4DE748FF1;
 Sat, 23 Sep 2023 13:48:55 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E08CE7456A7; Sat, 23 Sep 2023 13:48:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DDF04745681;
 Sat, 23 Sep 2023 13:48:54 +0200 (CEST)
Date: Sat, 23 Sep 2023 13:48:54 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, mkletzan@redhat.com, vr_qemu@t-online.de, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 02/13] audio: Require AudioState in AUD_add_capture
In-Reply-To: <20230923085507.399260-3-pbonzini@redhat.com>
Message-ID: <af692de9-1bde-6af1-2d10-c6398d489673@eik.bme.hu>
References: <20230923085507.399260-1-pbonzini@redhat.com>
 <20230923085507.399260-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Sat, 23 Sep 2023, Paolo Bonzini wrote:
> From: Martin Kletzander <mkletzan@redhat.com>
>
> Since all callers require a valid audiodev this function can now safely
> abort in case of missing AudioState.
>
> Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
> Message-ID: <c6e87e678e914df0f59da2145c2753cdb4a16f63.1650874791.git.mkletzan@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> audio/audio.c | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/audio/audio.c b/audio/audio.c
> index 90c7c49d116..42bfa330146 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1876,10 +1876,9 @@ CaptureVoiceOut *AUD_add_capture(
>     struct capture_callback *cb;
>
>     if (!s) {
> -        if (!legacy_config) {
> -            dolog("Capturing without setting an audiodev is deprecated\n");
> -        }
> -        s = audio_init(NULL, NULL);
> +        error_setg(&error_abort,
> +                   "Capturing without setting an audiodev is not supported");
> +        abort();

This looks suspicious to me but I don't know if you can do this. Probably 
Markus can advise. I would use error_report and abort() or error_setg if 
you have an errp then return but this func doesn't seem to have errp.

Regards,
BALATON Zoltan

>     }
>
>     if (!audio_get_pdo_out(s->dev)->mixing_engine) {
>

