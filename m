Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D017E8B19
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 15:03:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1oYv-00048G-6X; Sat, 11 Nov 2023 09:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1r1oYs-00047Q-F9; Sat, 11 Nov 2023 09:02:10 -0500
Received: from mailout12.t-online.de ([194.25.134.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1r1oYq-0005iE-M9; Sat, 11 Nov 2023 09:02:10 -0500
Received: from fwd83.aul.t-online.de (fwd83.aul.t-online.de [10.223.144.109])
 by mailout12.t-online.de (Postfix) with SMTP id 2BF461A9FA;
 Sat, 11 Nov 2023 15:02:05 +0100 (CET)
Received: from [192.168.211.200] ([93.236.156.187]) by fwd83.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1r1oYm-1jfTH70; Sat, 11 Nov 2023 15:02:04 +0100
Message-ID: <5f24fcc3-7cdd-4794-b556-cbcde7654176@t-online.de>
Date: Sat, 11 Nov 2023 15:02:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio/es1370: Clean up comment
Content-Language: de-DE
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20231110164318.2197569-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <20231110164318.2197569-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1699711324-ABFFC99C-F0452A59/0/0 CLEAN NORMAL
X-TOI-MSGID: 4be6650c-2177-46dd-aa26-be9e6fa25845
Received-SPF: pass client-ip=194.25.134.22; envelope-from=vr_qemu@t-online.de;
 helo=mailout12.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
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

Am 10.11.23 um 17:43 schrieb Peter Maydell:
> Replace a sweary comment with one that's a bit more helpful to
> future readers of the code.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Volker Rümelin <vr_qemu@t-online.de>

> ---
>  hw/audio/es1370.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
> index 91c47330ad3..fad55412119 100644
> --- a/hw/audio/es1370.c
> +++ b/hw/audio/es1370.c
> @@ -670,8 +670,13 @@ static void es1370_transfer_audio (ES1370State *s, struct chan *d, int loop_sel,
>      cnt += (transferred + d->leftover) >> 2;
>  
>      if (s->sctl & loop_sel) {
> -        /* Bah, how stupid is that having a 0 represent true value?
> -           i just spent few hours on this shit */
> +        /*
> +         * loop_sel tells us which bit in the SCTL register to look at
> +         * (either P1_LOOP_SEL, P2_LOOP_SEL or R1_LOOP_SEL). The sense
> +         * of these bits is 0 for loop mode (set interrupt and keep recording
> +         * when the sample count reaches zero) or 1 for stop mode (set
> +         * interrupt and stop recording).
> +         */
>          AUD_log ("es1370: warning", "non looping mode\n");
>      } else {
>          d->frame_cnt = size;


