Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D14576FE5B
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 12:24:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRryA-0005zd-AW; Fri, 04 Aug 2023 06:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRry6-0005vh-Sx
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 06:23:38 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qRry5-0008Vd-C3
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 06:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691144614; x=1691749414; i=deller@gmx.de;
 bh=QPWZSmqwwLy4eMq4cff63ufEu4uEhAL38Jth1krbcu4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=biio5oqb4/xQ8bmBIiMvgx9LuP+nYc1XLY5EAAfaA2QRpuNxRtB0J8bal1uYezwom8e3gr5
 Ft0v6UZ5HOYOEOtxW+Np4XSI+OvwCCyd2vNueKZ8KM1QN4Bwj88OFmbYYvEC7QGntI+oME4+O
 rHBvzcNUtte1NGvjBZCA/sdy5hen42dbc2fA+C35A3lbA+wSicAHUvupmqbC1hgvP7gyJ3kBY
 sUOCVmDgZWrnKSqyId50CZQ8P172e4Awf6sDRgXj6xdM/1DU/87ARfA8FdWh1CfWYmUjyK6Pb
 kpiWI9mG8VsAC1HKUHdMziSeBZMrUdSjE2VpRhTd2/8Lm+TJmzHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.152.187]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMXQ5-1q9vsH2Of9-00JeTF; Fri, 04
 Aug 2023 12:23:34 +0200
Date: Fri, 4 Aug 2023 12:23:33 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, joel@jms.id.au, akihiko.odaki@daynix.com,
 laurent@vivier.eu, deller@gmx.de
Subject: Re: [PATCH v8 15/17] linux-user: Do not adjust image mapping for
 host page size
Message-ID: <ZMzRpfcOUWb1KsK0@p100>
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-16-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804014517.6361-16-richard.henderson@linaro.org>
X-Provags-ID: V03:K1:OP3a10+08PrfO3KnwDe6F/35IMOauUvzLbIk1Q2DfnfKhAJopLC
 XefJXpBhHzFb2+j9NSaGUDML83X+W36ADrNg6HcbPMHPLj548vz0GycPg3ppecDJwFYnWcb
 1INBv64jqf7HMJNduHnTOSFk6OMYjoUwDWIM66m3Wua1BQBJXp7atU05yCVF5zOx326Kw6N
 Pw1T/sMFQWhArNgDnoqIg==
UI-OutboundReport: notjunk:1;M01:P0:ajzBTX7CCaI=;/Uoalx9ZanenX0wqqhCO1zt3CLB
 B7vTq3A2/Gx2fV2dWfKduOALk8IX+i30EUkiA+pQB+uJFGDQu1MMOXlusqbFckOnR/xZl34DG
 A50ccsYYUb1QbK+DAI8dXGABrwFkD6RKq/cNtwcHD5aqGF9KI5fnMaBj+qPiIs4kSgC268mol
 ZxLHQlTIr11ZiOT8SS5uLbD91q1qKds3mlnvVolRLJM50KhVPnv/Ek42CHlYrurKtwsJP1Km/
 vThW1fH1OBR+roqAl6FJKt7g8iOB1usQfFSg5a2TbeQLgaLE+EuQmnhsjOSka2oKyprJnu9TL
 payVTGcEZrR3wRaZCVyIfpXvWyItDUwNsjShI9HGcorg2NBs2reu/9bq3OaHqe3+SurjP9oXV
 tFk6AacykeFamUoZqtozyiurU0bruoiuf5lJNlEWgiiepNUyzL/A4Ng7ebD8nyE4ZBH4lqwbz
 DL33x6f/3ddjWuXYnIJhJPa7+ya4IH1TuQu+AWVHoUUgUtLrmqMxBPrPZSBpKM1EoE9C28Paf
 x5ECloYG1zKwAlAwraOyeGY4BSHr4quv8lcdAKN3gI2PXe8E5CE53pSGvOkSB6jHPt5kLOpUX
 UBLEKBBWUpffgzewB3leYfCzrVWuFRzisrBqcbrTCN7RtbdE9A1h+MkOaoh0EpJMOOvNCZrME
 RYr0gcYXBSoQqKYepJRHA0+G9W4K/65lpnI61aOyS0Or6YdKOuMQ7cA3gFjFDRhy5cJzp/iKk
 luBqvDGzWp2PLB1kK2s88y9U2Yly+H5lqNkoLPMVSFBFScgWjSMFWvN1UYDOKUaqvNjPYr4Cl
 axPf9LRw8doCmV2ueoDiooGsyYSbjsHZ9ophJ6sKoSUDViGfNPIJxmr5z4DrI7h0O7JQMCDBV
 gbTIDjHwt6pOdSu/rbrEVbhwgCfsSJMwt9cNYPWaDQvCixcXTiVaFa61RjAvI0LQYyaOeWgA3
 hf21ZSzfC7ltzkdod/NBjeLiD2Y=
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

* Richard Henderson <richard.henderson@linaro.org>:
> Remove TARGET_ELF_EXEC_PAGESIZE, and 3 other TARGET_ELF_PAGE* macros
> based off of that.  Rely on target_mmap to handle guest vs host page
> size mismatch.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

