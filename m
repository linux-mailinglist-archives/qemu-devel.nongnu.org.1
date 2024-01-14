Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB7C82CFF0
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 08:38:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOv3X-0004cr-MO; Sun, 14 Jan 2024 02:37:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rOv3O-0004bz-8A
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 02:37:10 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rOv3M-0006xC-H3
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 02:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705217819; x=1705822619; i=deller@gmx.de;
 bh=bsLo9s7uSPg+Km5iduTAITax52BI/gz+d1vW7OoW8wc=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=khkIl1p0nERIFQHgkCQXCs2fOzrluUTMcDDE1M/UjpVGbf0XNqAYNRWHSLSO7Z0j
 TmvBLYuN4U5T36CV/IFmhYklAun5eyydAK3hgNstZbmEGenBRMxd6Wtk+0B07TgH5
 CtM17WlnBu4JeSIz3F0Y16CMpkCLk8B3YeGS9uqvfrGE3tQptVK7Rx7cr4atd1Nar
 Gk4s3UnyM/NJxZSnEQOb5JCFPNVjBW9qXSCKSx3wTVCMKRDlZvIHVvdfxlhYTthCi
 o3YH+wWhqtdQB2IyI3Pdp9jWEfwKTk1WYOb6erNuDh9uA7rAYt5+JTkiTWPfz7aeO
 8i0pslltbdEVSY6MTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.155.205]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b2T-1rWLZ809KX-0081kw; Sun, 14
 Jan 2024 08:36:59 +0100
Message-ID: <13c8b1e8-0c76-47e1-a4b4-3e8f4abab0fe@gmx.de>
Date: Sun, 14 Jan 2024 08:36:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/88] esp: don't clear cmdfifo when esp_select() fails in
 get_cmd()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, hpoussin@reactos.org, laurent@vivier.eu, thuth@redhat.com,
 qemu-devel@nongnu.org
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
 <20240112125420.514425-2-mark.cave-ayland@ilande.co.uk>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240112125420.514425-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hWlPLaYcoLID+HjNpoR7qP1QPHb9rahk1h3vodO0PrO2bcb4Te8
 xj+qlPgX6wczi2B8+PfOKt9O9iAJe0bOEUYmgpW37Vy2PrmZj0lmBKKkhs8VE0k9uRA2q91
 TSrhc23KFOl4+hC09xh10dVBEY171fO+UCju6Abh1M4BMX/UQ8Gy8QdaXzH1yI4s4FI+79H
 C5hIy+7nIC+QKg0/ttoeQ==
UI-OutboundReport: notjunk:1;M01:P0:Zbh1IlB/g2Y=;tps/sbx4GpfNtSBODwRUakqo/c9
 NIfCCZA/A/X1qHVToGrC2WSM9NfxZscOnOyXnJ5impJo9VdElzeN4w+GxLH+UVxksJ/kXW/Bc
 Aw+Jq/pqMfx0aAwYOuybqJwG31lyQjnuK/co2wYhGBui5xWCFGe/HgSLOD32bJSOrS6zsD1RO
 sRz5+QpkL859x2ZROgd+rqEun2BCrpJn8gpHZWoGSmNpxSrDv4WVh97vG1OYY8Hm73ArcWVBd
 c5c12s2vNKVr6OK/u5cvep72YL8P9k5c5fiT/eT+18XVijseNrInPGqS9W8AR6YzW5XeP/Bzf
 CMvIv5+KpEHZc27FvBedEJgzc0VYq/Puzy5yghXFjx34BRFeXqItnY6KEfEWYVGDwL206ZiBN
 rP2hhEOqb+YtohIlwyKlEEllh/DJMktPokWzO4yhjpv7ZtbEPSwBVNA2DLGBGohdF2FHvk+g4
 Xiol+OcTpQRflwCbTgjW1E9NQ8bXdf+CsC7UXpPJQtXCaTU4bcgs64Id/NmJPhutWvv5cLPJ9
 2jVlgyQKJLrQhTslIKfOVIylB91VIquTOZRt+5aEKKnJRMmd6ZYkOuxaV6ew0KnYgm3be8pQf
 sPJNgV5Nmhk+ErCYhurQuFsjWLEO0BRw3Njg6z8/VwWVnfACXJ3y8ptm2dhY3sjaCl6Bkb9rR
 0IJ6gssNB5uJXft+VKyLSYUXXNQAGcbdruLad71UWk5xlNuAHl6ElVKWGWBcUmj/3b79vuUFb
 UxT7Q4ZPiLC/zCq1Ua+F76FFGlKBE1qiZf515h7U30+jgjR9CGhx/LFZAf2IdyD3dT7tZHwQZ
 +MHrquv4FzNnK2DjxjeLSMU57ELQ+FRI394dUkWCBadu6pZA0bjyfSjFoWhXj96AfvLZn63sl
 TogfUpfTV3cQf2fXgDxAvf/UxxGaoLjj1+5VlEYd4o+hCvNhgvmdAboQiCtEXMF/WpnNVNH1d
 2hL0gQwukV+EArMK9x4K5rSinsk=
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

On 1/12/24 13:52, Mark Cave-Ayland wrote:
> The FIFO contents should not be affected if the target selection fails.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

I built and tested this series together with your "esp-pci: fixes for
Linux and MS-DOS" on top of git head and they fixed all outstanding issues=
.

So, you may add
Tested-by: Helge Deller <deller@gmx.de>
to both.

Thanks!
Helge

