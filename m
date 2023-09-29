Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC9E7B3188
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 13:38:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmBoD-00075t-FF; Fri, 29 Sep 2023 07:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qmBnz-00075R-Q0
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 07:37:11 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qmBnx-0002jT-C8
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 07:37:11 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id B153E757248;
 Fri, 29 Sep 2023 13:36:33 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7F5DA757244; Fri, 29 Sep 2023 13:36:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7C9C675721D;
 Fri, 29 Sep 2023 13:36:33 +0200 (CEST)
Date: Fri, 29 Sep 2023 13:36:33 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, berrange@redhat.com, 
 Martin Kletzander <mkletzan@redhat.com>
Subject: Re: [PATCH v3 02/14] audio: Require AudioState in AUD_add_capture
In-Reply-To: <20230929085112.983957-3-pbonzini@redhat.com>
Message-ID: <d7008826-7667-0dfc-c1a0-15a4b88ad693@eik.bme.hu>
References: <20230929085112.983957-1-pbonzini@redhat.com>
 <20230929085112.983957-3-pbonzini@redhat.com>
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

On Fri, 29 Sep 2023, Paolo Bonzini wrote:
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
> index 2f479657117..4332c4c6ce8 100644
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

This patch is still here but now Markus replied and quoted error.h that 
says this is wrong, error_abort should not be used in error_setg so this
should use error_report instead.

Regards,
BALATON Zoltan

>     }
>
>     if (!audio_get_pdo_out(s->dev)->mixing_engine) {
>

