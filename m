Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4EC7E13F0
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 15:43:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzeKz-0005zr-Sb; Sun, 05 Nov 2023 09:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qzeKx-0005yt-OA
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 09:42:51 -0500
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qzeKw-0003YH-2v
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 09:42:51 -0500
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MCsLu-1r8PlI0QFM-008q03; Sun, 05 Nov 2023 15:42:48 +0100
Message-ID: <0311bed8-2ba6-4f93-abe1-91f85993ef9b@vivier.eu>
Date: Sun, 5 Nov 2023 15:42:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] macfb: allow reads from the DAFB_LUT register
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20231026085650.917663-1-mark.cave-ayland@ilande.co.uk>
 <20231026085650.917663-5-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20231026085650.917663-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Vzk7YT2M3EcC6Dt4FpmKk560hmgo/wIxBPkb+5stD0azyIwAqS5
 8yLHeFt4UqPB8Ih2H6b8tKU7nT6In3sfWxP+ELRXeN5Mfd15DGTCkneF0Xte4BpfPzrgSY9
 LcWaOkNnmaM0PlHdAx1Qh+pgOYyr6iYjcADLdTm+gOK45pSmCk0K0CBS4ewrzdYF5QbPUtp
 /PgCTecGI7EU6UdF3rU1w==
UI-OutboundReport: notjunk:1;M01:P0:Vp33Qk2EZLI=;h6/J5Q/BZdordh2Evrq7WWRZKOR
 uD8maYmZZxQEHyOuGCM8e621KvQjJDHf+N8hj0PXBSJ/rd3oVc74D9fHFUqLUiDdZwsbbHao9
 GJahbTLyg+QzoGW5SO3YuQf+AHHJY+q8IranXRGaHt51s8zSMQmheb8zen5CUAdApQnhqluKF
 76l45toRPJFGlWiN8Izm/g6QYe6hp747vdnRfanBrarnFVYlbF7AvyXNBWxePlbuZM/7/0nv7
 E8gnx2Iy7k0GqlYMoXX3/yK34mG5xFd+X8XfSxZtjAvR0zZ4/kbgIAWuYY9zes9/y8sUFTdiz
 s+tNh8BeO0prLgtNCd+RKhqjnriu0k+VsDH2+5316KXJOLsMrlUBtLuBdRGJd1KaMJVqQSp2T
 r6D9EuIhzBUyCISnMaNvlousRVs2mGmVIc/OWL4IsrVEtc9O6gSylxgiaVK81l5FVnZFZTeEB
 O9F+JnLklmQKnOkZq6TR6LFUIBVIuYuJ+MDe7SMizK4F0YABeP6XV0MkFWIU5UGRYEvMEG/g5
 f8ckrAAJQTLHRf2GubuOnHbyxL9HV66Xs/6OcK3fwKt3Kvv3IgQUncIaDFEPDRwJFzrNozUUs
 4upmliC3r0TOFzNtcpBWbRniOH9Wx8mYZIRkdVkgn5ljokpOZueqqh1T2GLQygaTmXPS6AEQj
 nlOuyyvhSRIE0I1KNGzuO3kCPGFj+RJH14ozLSmJEde/AIQi85JLZg1TgrurpiJa4ZZfgpSO8
 L4TOsddBU/488TZVJ9kq9YQp9QLQkrY8sY3ClchhNanJLKGF61cXbGwOMKaiMkhmFCXkXSfTJ
 eGjDuHgSCDk2ppn+flXt2/xBYwrDNu2aVRYpWZAg+GvUZ3s1ousTPsaii5UzVCGwKi+U+1qNN
 BRjiik/OqLHpKYg==
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Le 26/10/2023 à 10:56, Mark Cave-Ayland a écrit :
> This enables A/UX to correctly retrieve the LUT entries when used with
> applications that use the MacOS Device Manager Status (GetEntries) call.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/display/macfb.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/display/macfb.c b/hw/display/macfb.c
> index 4a1c75d572..d61541ccb5 100644
> --- a/hw/display/macfb.c
> +++ b/hw/display/macfb.c
> @@ -537,6 +537,11 @@ static uint64_t macfb_ctrl_read(void *opaque,
>       case DAFB_MODE_SENSE:
>           val = macfb_sense_read(s);
>           break;
> +    case DAFB_LUT ... DAFB_LUT + 3:
> +        val = s->color_palette[s->palette_current];
> +        s->palette_current = (s->palette_current + 1) %
> +                             ARRAY_SIZE(s->color_palette);
> +        break;
>       default:
>           if (addr < MACFB_CTRL_TOPADDR) {
>               val = s->regs[addr >> 2];

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

