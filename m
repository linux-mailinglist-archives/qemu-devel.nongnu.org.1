Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED23A7AE75B
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 10:05:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql34b-00010T-Is; Tue, 26 Sep 2023 04:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql34Z-0000yA-IV
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:05:35 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql34Y-00083Q-2D
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:05:35 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N8XLj-1rgT7q1atN-014VfO; Tue, 26 Sep 2023 10:05:31 +0200
Message-ID: <67c4c634-7dbc-dedd-118a-bd30a05f2c4c@vivier.eu>
Date: Tue, 26 Sep 2023 10:05:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 16/20] mac_via: implement ADB_STATE_IDLE state if shift
 register in input mode
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-17-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230909094827.33871-17-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:29yPuOguhkCJM050tomOePc99LyVBc9ag6b78oQwkeYvPLGQv4T
 dwIxJ9MIjOuLuGDQCeIh+jEqPxHCKlGM5gPFrWIjfJFAUNrGSaCmBjM/JFzCUYlgwzu2YcV
 cPiXYHHKua9rRJdFtnZvZEg5dwCDFuRaoheXU/u51g7C6+8PIlIIsS7r2b81GzIVulhCIIO
 N1KP6OmjkuBfIYCOHdeDw==
UI-OutboundReport: notjunk:1;M01:P0:1mVBvVmG5ls=;KFBOIIDNtKfggQ3Yucw31WwGXcm
 1TBLQh7G6+taObIhO7VjGOopQYCWjr4ou1xCwdPe6OIEuMdaKD8lwAT9Jn8+RRsGO0Ai8Vj0/
 eeYI9/TgVM1pkzqn0ql8qWb+ff3cxSvDmzC2HaBXxJuyknsuqXpoAFcoyMuD/tmlt0iE8KHvq
 nnEPE6fo1DztnDnCLdocoEiHgEGN/Vn9vFafTTAWUtSSRLNm33DturNBtNh6EZobGi42oZs83
 cF5uiyRN9uRyvdw6MELEPOKm+x7hJ7858dI4EV5M4y1/1d3HoJFPvzgHoo6E2B9Nm08OkK1Ys
 J47hOn+72f6CUDOolP6f/diZnme230dZceL5KdCmTNVIAXj0xSffDGXrRQtI/8CpA+dlxvthy
 dfIdfl+MuaNZYEJ8JrtaFpmd7fInaY9T5PFnGsiSpLeE5xgAdbSk/rUwHDAnToXFqe8P1BnqJ
 G+hqybukkCDvxggJME9x4i/qDY1vcKatVEUHw/BAzFqfPWYdxaAuENGgBQCyQe9Ow8LHCG7cA
 PrZSLKJglSQU9Xn5HfmjO5Jt3fJLwUAIclNt7E4jwd+yZwE1iwmJOE3vxlrnFwayBIccXudiJ
 1tGmaFPqDOSHwVqW979jO8E+O3Ezm9C8QRgmVxhTJFRIw7omyOBYDB14YKUzsAkMxCznHO3BW
 wpf7fzMjMqEm213dpS5e1NhPsrieH34oF7lz6b6buWKwOMNTL2kmnzbeOCz/37rXFL1Zf6u0X
 wsl8WPWh1a9ZFQ0IbpI/kMfb84WD0DXWxzCSGtaoh8lcdXMoFP6bYe6SMDEDDxU1P4tLV2hM9
 RrbH2lfOyvYO42kqJpufyaXSoMaGs+cgaO5Lv1ncDZLl+Tmjtc9WZBez3DjPdi7EWqY624FZ+
 SzUBxv+PikOIURQ==
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Le 09/09/2023 à 11:48, Mark Cave-Ayland a écrit :
> NetBSD switches directly to IDLE state without switching the shift register to
> input mode. Duplicate the existing ADB_STATE_IDLE logic in input mode from when
> the shift register is in output mode which allows the ADB autopoll handler to
> handle the response.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/misc/mac_via.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index 208216aed3..398e8d1967 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -702,6 +702,12 @@ static void adb_via_send(MOS6522Q800VIA1State *v1s, int state, uint8_t data)
>           break;
>   
>       case ADB_STATE_IDLE:
> +        ms->b |= VIA1B_vADBInt;
> +        adb_autopoll_unblock(adb_bus);
> +
> +        trace_via1_adb_send("IDLE", data,
> +                            (ms->b & VIA1B_vADBInt) ? "+" : "-");
> +
>           return;
>       }
>   
Reviewed-by: Laurent Vivier <laurent@vivier.eu>


