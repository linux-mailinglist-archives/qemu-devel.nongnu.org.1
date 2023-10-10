Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C587BFB62
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:26:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBnm-0002gc-Ht; Tue, 10 Oct 2023 08:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qqBnj-0002g8-9r; Tue, 10 Oct 2023 08:25:27 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qqBng-00078U-Lk; Tue, 10 Oct 2023 08:25:27 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 18D27756A30;
 Tue, 10 Oct 2023 14:24:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D6B47748FF4; Tue, 10 Oct 2023 14:24:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D481674632B;
 Tue, 10 Oct 2023 14:24:26 +0200 (CEST)
Date: Tue, 10 Oct 2023 14:24:26 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>
cc: Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH 0/8] hw/audio/es1370: bug fix
In-Reply-To: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
Message-ID: <74bd8b1f-7db4-9385-0d1b-64c505200cd3@eik.bme.hu>
References: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2050981125-1696940666=:43516"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2050981125-1696940666=:43516
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 17 Sep 2023, Volker Rümelin wrote:
> Cc: qemu-stable. Patch 1/8 is a bug fix.
> Cc: more people. The maintainer of hw/audio is busy with other projects.
>
> Earlier this year I was asked if I could help to debug an audio playback
> speed issue with the es1370 device. While debugging the playback speed
> error, I noticed that the debug code of the ES1370 device has not been
> compiled for a long time and has bit-rotted. This patch series fixes the
> rotten code and also fixes a bug I found while debugging the code. The
> bug fix is in patch 1/8 and prevents corrupted data streams. The
> playback speed issue was caused by lost interrupts. Patch 8/8 helps to
> debug this kind of issues.
>
> Volker Rümelin (8):
>   hw/audio/es1370: reset current sample counter
>   hw/audio/es1370: replace bit-rotted code with tracepoints
>   hw/audio/es1370: remove unused dolog macro
>   hw/audio/es1370: remove #ifdef ES1370_DEBUG to avoid bit rot
>   hw/audio/es1370: remove #ifdef ES1370_VERBOSE to avoid bit rot
>   hw/audio/es1370: block structure coding style fixes
>   hw/audio/es1370: change variable type and name
>   hw/audio/es1370: trace lost interrupts
>
>  hw/audio/es1370.c     | 289 +++++++++++++++++++-----------------------
>  hw/audio/trace-events |  11 ++
>  2 files changed, 143 insertions(+), 157 deletions(-)

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>

The whole series also got a reirwed-by from Marc-Andre already so maybe 
Gerd should have a look merging this.

Regards,
BALATON Zoltan
--3866299591-2050981125-1696940666=:43516--

