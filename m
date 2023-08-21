Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D848678258B
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 10:35:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY0NC-00075s-Uj; Mon, 21 Aug 2023 04:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qY0NA-00075h-LI
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 04:34:52 -0400
Received: from mout.kundenserver.de ([212.227.126.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qY0N6-0001zf-3B
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 04:34:52 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N5FxN-1pZPOP0a9d-0117wp; Mon, 21 Aug 2023 10:34:40 +0200
Message-ID: <75b13a6f-5866-4948-00fb-fbfdb7866e3d@vivier.eu>
Date: Mon, 21 Aug 2023 10:34:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Funny results with long double denorms on m68k
Content-Language: fr
To: Keith Packard <keithp@keithp.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <87bkf1l9hf.fsf@keithp.com>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <87bkf1l9hf.fsf@keithp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lGQRLX6U/YoOsDS1XOKuBeJWLU97AC02EGB4hLL5MGhs2ECKLPV
 t7zfuaImHpY6vpOe9907yA9OuAfaC2W0uoZSRpFTmnZ1eJ9glfLr5y69+WseQltJ104D9I/
 WyvKB6KPIDseKlWn27sDcByTvTHS3FKbWUGjPKMm2yn8vSh9bdIam0AiY/BG3Aa/ZgLZtnZ
 bxhsb7nrYWjb0PFEpotIA==
UI-OutboundReport: notjunk:1;M01:P0:F16c1T6wDUE=;W+IlWp7uAbgFQkXjx/AE4tZc5hC
 8Vg0Fr63xSeNSYM8ZHKnyvngXizTke0rMNrXRj0Nw+Tt0mNCjPvD6xU1hwwp/HtXE6vwj//p1
 2BRxycbDnAvbjnpEQmeVFgFpg6XhM8f0JE1q8tmPTYdtHXCdUDajIjQutwbw0qpauWiNNI+OF
 /sgJb4Fd5phv5BBawdzu9HQfGBHYTyncoi/UYHM0Rbz2gdfzwWFXdGtUZNZNL60A8u6bgdhvi
 phcxNbOgrhsA83nWe452GSkew8fL4yKyDlFwGhMtQccdmxS3g9rRNl05cWsoFdJ8dfnuzrWo3
 D63dElgJB2gnipbxleJUgA44KNpH9O2F1cbd2tog9ICwhGN5cEcMMQLM6bJDiQZKaL4nW5FiI
 551O7InSNWeiIBBSUMMfMXQ8yrKksnvgSAuf2vXLlPtoJa8Wmi1hjfmgev1F9y1DAxu5bTSSm
 dT9CqH/3DHeYHpvEB9pyAwRjh93LnMSU1KhHwZmN4FNvJCa5f/vtfL+uKxfac02jRmezQGVhI
 NIb35MO3N/96uI9R0g3ElkNs/KBJxyyuT2aLgxAAPx7YqjgXkq3eXCJUFVLjzya00hL7KjV2/
 0pUemQs2w7vkbc/yue/cpwXeneFWw8xCYLAkeG+AnCCttJJ4tVbxtOXehH0FgSpK6Wqn1uXok
 HgZoYXwvEGRgX/dDgc2jJdd+Pli1z922Ju6XxDOY7o5QBgPmoSPAxNOOKl+JZDnhOYIr3waTV
 QrW1NTMaUd7muTyaheEKY4FikD+Ex3wop8fh3VOt6FEPWQuKr89vyuA8Q4lB0wWV/UJQo8AiR
 BrDwK+Pd5SoT445N0fxIeC4p9qgjCRzKvVeqgpH4e1xQj9xiBY+xP9DH7qG+F4mFPADNyqF4k
 L4nWvrjQ1hPACgg==
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.279,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Le 20/08/2023 à 22:55, Keith Packard a écrit :
> #include <stdio.h>
> #include <stdint.h>
> 
> #define X       0x1p+16383l
> #define Y       0x1p-16446l
> 
> static long double build_mul = X * Y;
> static volatile long double x = X;
> static volatile long double y = Y;
> 
> static void
> dump_ld(const char *label, long double ld)
> {
>      union {
>          long double     d;
>          struct {
>              uint32_t    exp:16;
>              uint32_t    space:16;
>              uint32_t    h;
>              uint32_t    l;
>          };
>      } u;
> 
>      u.d = ld;
>      printf("%12s: % -27La 0x%04x 0x%08x 0x%08x\n", label, u.d, u.exp, u.h, u.l);
> }
> 
> int main(void)
> {
>      long double runtime_mul = x * y;
> 
>      dump_ld("x", x);
>      dump_ld("y", y);
>      dump_ld("build_mul", build_mul);
>      dump_ld("runtime_mul", runtime_mul);
>      return 0;
> }

FYI, result of this program on a real hardware (q800/m68040) is:

            x:  0x8p+16380                 0x7ffe 0x80000000 0x00000000
            y:  0x0.000000000000001p-16386 0x0000 0x00000000 0x00000001
    build_mul:  0x8p-66                    0x3fc0 0x80000000 0x00000000
  runtime_mul:  0x8p-66                    0x3fc0 0x80000000 0x00000000

Thanks,
Laurent

