Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5517F7E40D8
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:47:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MPf-0005Wa-8O; Tue, 07 Nov 2023 08:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1r0MOf-00057o-Eo; Tue, 07 Nov 2023 08:45:39 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1r0MOc-0006Fk-9h; Tue, 07 Nov 2023 08:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699364716; x=1699969516; i=deller@gmx.de;
 bh=Clctltb9sSVFdrstnb5+swlPMe1C/twPgv3hEpw2siw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=cKqQy+P6KY2ziFS/jwt+y66AsVKL7j+OmrCKuUdwJUOZa6nIEvsIHdstW5Zetr3z
 mrbUWWUuUL+vvIoXVkScYohIpZaTpbIkjUmIqSPIXPCoumZgvQKheHOXheq4kin2K
 hAGiYdka9rTLCjA53SEF4mOPqxeqjlbjT/uzBLjgMrvV2bdKHbZb1ZKIit3hNBhIr
 MzZaTnkg3lHteTUkzDp8aKnvOc8MZEXQd+Jp8QXnMLdreOIIEARysFGI4Y07NCxIr
 dqDh0f+Qy+rZaEZZQ4cp3YKzeNM3vafXcI1F9MMBZsjSZDdQHVgD8N+L8FbYbOuBv
 CURHTTv2QItMct96ow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.157.202]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJVDM-1qgca43Inw-00Jsue; Tue, 07
 Nov 2023 14:45:16 +0100
Message-ID: <e4d1e314-5080-4ad4-bb31-281dfd74a184@gmx.de>
Date: Tue, 7 Nov 2023 14:45:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add artist.c to the hppa machine section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20231107103044.15089-1-thuth@redhat.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20231107103044.15089-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yU3+l3ax0RfL1H1NiZ/662SUh/TzpwGYxOlqlbu3SNr7977XVs3
 5RKg6U6A1ARPmOlOSwxf2r2YAoHB+aLrNkjA46mNrybWj6ZZueTCKPW0PB1VCYyZu/5wREE
 yKOOgAT2VcthnskSxPTrXvqMbGYZzkrFmRbQZs2/63c8ovxQKBm6vj4waUg9j82zBwWk3un
 QbG1VNkpDFDe2P06KNP1A==
UI-OutboundReport: notjunk:1;M01:P0:+vJacD3ehjo=;JTroc8gwVLzLaEY/lzcdn67yGjf
 2DujjlFPWlfLCrfqMP3wRatSIVoFsG9sTXXWgp9aTOBWOJYjBAWylmAAL+qeH82gpcBY85QpU
 ehg2bpGYlxRnKNKm9tn/Y+C2zO7QPahbo65IVYfpqpniqF6tbYAP5wP6Qjgzoz+UNa5SNM/Hy
 FvQUyWvgHAD/VkBO0L9XXeD3GHylplXGkdNzJPchSk48YhCv6f1SQ8OII6p89toY4hClVl+8O
 G8svjZ8NhML7CWnhsmNTCEbaVs+ydypvj8V8KDdm4AALTtuC+yzTIBLMWp+fl7MktVwqhxJu2
 A7CGLDS/nht0bha16rPY4lluR6Q5I4PUYB1VLrxEXP6D92/8Dad1wE2p0TCVP49qkuDxM1mJo
 yQzIWRXeMQ5ETaudgU1mwnjgq2uw0c3KWD9XOykeboyZ44VPVHWAXGfl97PBKKIfN8Gi+bHCD
 WKv0gmQSdBLNGXjTOEhS87SZmMaatMiQhFs8Of+d5zcYaAZzyVWRmaauxdHjyaLHcUuRpkTIq
 NlET5zeujOrSAcmG8kh4nThpLVEjch0qQCpu0Zy68H+7g0zdPLTuCUU5AFBoTPScpaNObehDP
 M0JhQezwk2y5ZEv6CmuS+Sfe58cmO/6ltktRa9WXwUXmqS5cYVz98h4KZqvuWvLZmQEHFGmXV
 XRRzoAqrR4nl9zbECvQqmOcfJQZ9Hy50YDd8F3TqMrDByje7q3jXgElVXoTSnMAcJiA6J8R6P
 q9+sY7OGGQg2GCJXu0QsaabYHun+SPWL2ovIeHuR6covlhfS28OY6ktZe2oRzPA8sMSsNCItM
 0xD8hSpfWr17h+LKjmoXo7Jn+cZSvJ6mXbnyuycSRbyxMWop+QtgYtI/1kvODepP1XI/3WlxQ
 e1+nmtmzi2/pBatVqmbiPgzOG8dlfiS1CZzydmghSdY6wnMGDrqHBLmzk2x2c3SS4omnL+BIH
 66BJA9LroQbbx0QEEmeqq04zO/Y=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/7/23 11:30, Thomas Huth wrote:
> The artist graphics adapter is only used by the hppa machine, so
> let's add this file to the corresponding section.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Helge Deller <deller@gmx.de>


> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c1ddf9d623..0c2ef567f0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1204,6 +1204,7 @@ M: Richard Henderson <richard.henderson@linaro.org=
>
>   R: Helge Deller <deller@gmx.de>
>   S: Odd Fixes
>   F: configs/devices/hppa-softmmu/default.mak
> +F: hw/display/artist.c
>   F: hw/hppa/
>   F: hw/input/lasips2.c
>   F: hw/net/*i82596*


