Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA7C7CD3DA
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 08:08:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qszi8-0006R2-I4; Wed, 18 Oct 2023 02:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qszi6-0006GD-Fp
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 02:07:14 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qszi4-0004s4-GC
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 02:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697609215; x=1698214015; i=deller@gmx.de;
 bh=55rsnsN2xcwHLIekWaeUko+R0iPxv7exak+loYDBRx4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=QxPdggc5sHaRtWaK55e+0Uw2x8/m1CHNvmJod/nV927+V3W+XmqwEqVv7GpQNYmVgkKnbG05Rdl
 SLI3yzFUHdjilzpaHMyvO3vFZ3kVYddbZdwPuHSdmAMi6K2ph1P04aM3/pOnDCnvWsznodTBROoic
 m5sH11KllUSIuzbgMBezDlETq4opZOPIbD9vSnCmmGbUMj+SQ3/EXpp7DYL+nD0CJojxZjBTFZ5BS
 PhmL5KRmUnior5gYJ1k2v+P0DQQ7paVqElS4RaGik2DoXTZaBux1c2eMTzUZdq++Vz19pTJJHHL9x
 Hg9EBgllToymJ2o7/ra9SSYwr0D+cljecILQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.146.99]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOA3P-1rCRIE1wxl-00OY2Z; Wed, 18
 Oct 2023 08:06:55 +0200
Message-ID: <8e2078b9-4962-46b5-a7cf-29866e39315c@gmx.de>
Date: Wed, 18 Oct 2023 08:06:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] linux-user: Replace use of lfs64 related functions
 and macros
To: Sam James <sam@gentoo.org>, raj.khem@gmail.com
Cc: laurent@vivier.eu, qemu-devel@nongnu.org
References: <878r8415bj.fsf@gentoo.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <878r8415bj.fsf@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LChzyLCwfb0z8+knBz85ioxMbqhWbmfivb5hltu+JdFv9W+wlPO
 khLt8NnZdINZtgXJYbG1SuIUqXte/CYVygG0E0ayGVtwTZ1XOVkNrtvCne3Jp+Peo6wbsbF
 upJQhdal3gMlovAbv07i1WL8H4E2KRs9LSnKGLXEmVVUFHKMJklFjH7n/Ple4KRBUTh3Ho/
 s5OfLEuyD7/Eg+1EJRuxQ==
UI-OutboundReport: notjunk:1;M01:P0:pywfkJr+CCY=;mJEc0wPXJemZu1/+mQwdYjsV6Es
 sJNbaeSjahjHRlMWyb0xHGkAN13ExrlMJFxVmuaw2WBSouS8OtNGSCUCvT5aP9AbYzKGk9n7E
 LYSRtSnYBMkKC7NqKEg6MERQrmdRs73fAwp+aUz6OYnXPn8aqKSBkyCRv1egfIG1WDQwhWpGh
 +tZWNJInH0HjEtHZuHIQyXZ9evkEbps2NU3WinjwYLesnaWXlXwEvREYEaufYBAWdhyc2194L
 zJo2D2WF1f/KGQr0RzLos3/xuXr8BYjEPmO5PRpXzfYDjneyJT+lWdhOmJZrb2HN0LrPz8VbO
 DOb74MAoSKmN3RERclK5dCB1f8TWWu04zHsRgmrr62Blx9TIdDiUtJQ1hixkkVUEzHV2v0kwd
 ClMTzYqzpTNR9fb8kLF1qrFPYSxVMs1RB4OeKP4GBPFCdP4QAM3oUdkHN4Y6FZe3rRrcHMdoE
 eNnQx/jxJzfFl9MX3Hea3e5ULrv0k+004dUWVTGn4YjvHY2c5cfoS94DnBHpFSyve7nG0JbhT
 z/IxbveZLKWYsfUCOzg46FZsrytwkPvnRREryyCcbYS3iDHkDTe9GDRAcD1Eqaqyn7bpSLc8v
 KEQYb/gliWIJIkLmgp5CEMqBQbeM7s+cimV33rhvqssVlaTndPMc1NwqMxRdw7xBSLIpNJcxE
 AweadzVp4K2CBkqS3kFbD0nn7S9JsZX2UdHkiJGidU5Qqzn6pAPxl2snjZtHqLpOCCS9hSDXz
 P3iNhSGHz6AbTRKjIfe4WbVTQcvBVWvDlH1Mbm7fLZ3FeJdGI/wM1l/jDUTHXnllTUJapfXGH
 r2rflllEAMR3sLCIwAXOUvt24YJYunBuXS3dwct8ilHNHwtyo68CSFqM8r+EU+OOaMMJarxG2
 DMf7OlKidfrfxw0G8xLmuAP1Awvei0JlwL9U0deekGV1F4AghCbiKLaz8hiCVviuoco1/gFw1
 kBhBdA==
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/15/23 13:39, Sam James wrote:
> Did anything happen with this, or did it get stuck?
>
> We just had another user hit it in Gentoo at
> https://bugs.gentoo.org/915809.
>
> It looks like openembedded (obviously given the author) and Alpine have
> been using this for nearly a year.

I might be wrong, but it seems this will probably break various 32-bit
linux-user emulations, e.g. the whole TARGET_ABI_BITS =3D=3D 32 block is d=
ropped:

-#if TARGET_ABI_BITS =3D=3D 32
-    case TARGET_F_GETLK64:
-        ret =3D F_GETLK64;
-        break;
....
Where is TARGET_F_GETLK64 handled?

Helge

