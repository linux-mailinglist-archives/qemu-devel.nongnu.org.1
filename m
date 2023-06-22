Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF6673A009
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:48:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCIng-0001SJ-1X; Thu, 22 Jun 2023 07:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCInQ-0001LI-7L
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:48:16 -0400
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCInN-0005IW-38
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687434489; x=1688039289; i=lukasstraub2@web.de;
 bh=qP9jCnrdh/L1HJlBpEa0+QrU4qIzImjbcD+AevDxfA8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=BpWHqj7Bek7O++14Y9uiRhsTJccftUfi6FxlJHgEd5OFIxllpyBQJmujHOhwNVtqCZmwXK9
 6UUHYCdq/Z7iEjVdMTKo65783P1UV4Cxxl9wEnpIv2sYVUdTjIYtqp41ac8QST5oK1Hssl9Cb
 kBUBe2HdxRvz8MaA1ykiw4Nt6zf69MMV/5cIdWbrjV9gCfsf494RsadYemIYmU4Bywn0rzn8Q
 CfPRESeseiOYTujuolvOA/hxZ/EqlfgCpT4+N2LE/spxYK1l9Vetdb6gRSYlr8qFn5hALuv1X
 UFiVH5GjQ+o0gGKpXTRORGPi4+tnFiy2QCEcxcTbRSD90wnvpl6A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFayq-1qIJ3n0Bw6-00HaZY; Thu, 22
 Jun 2023 13:48:09 +0200
Date: Thu, 22 Jun 2023 13:48:06 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 16/18] migration: control_save_page() can take block
 through pss
Message-ID: <20230622134806.53c74af0@mobian>
In-Reply-To: <20230613145757.10131-17-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
 <20230613145757.10131-17-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Iv2QemBm2f/+mL42fc30PmrchPGbsxE4TBNrJEhBKgwHFq7JWAj
 ofDAGU+hrQivwIygBegP4HrCf7S1FSxmL3SBJe7wqkPcm2i2NS39lK+pse7ezu7Y2FCVKWc
 LsfrQde0+2e/KnXWHXFffAVx5l60wxrMhdsm8UJC3RX2TQzh/Cktf0ksdDChu2ol7Sya6mC
 5foYcCi2zRJBBeItNSPNg==
UI-OutboundReport: notjunk:1;M01:P0:lXp02kDNspw=;/16jeRmv7xIdmijn8Ikh+Vh5ZFs
 vms2IJn1ukeWO50JpNnqbV1q4vTDOo0IAnCEaJUCaDdRxW7Mq4ucKfuSi3Ueov5m0RGzW1j0S
 wZKv6ckeq2JJzLrGh5Zej/IiDYTMz0XG53RDoFIDpWwIfId8B3asfSF0DDIS9ohA80S04Rx+r
 3puV1o+S/sPes3MsJdCtqrm0pNhrUatXTrsclQDQ92bXP7436QPWyBtnJW/SfLuXouq25/eIo
 mp0v6Y2Yb5go+ezl1Kp9qLJsgxrVXdwEuCt+ru90p9TVDjQ4BQWdxax3SqK5UpxPSGQ1pQzKI
 5616hpxuJMvO4et8aTjA6/PKtefxMoR7RXBmr1km1YwiK1ZvE8mwLISXq+z82DoVG6vhZ/fIp
 DttGZJdlsstH87spGFf/EFscyB2QAe2XMuHGVR1uv5BB0XnADxWjo+1WhdnMEjjOpDsfqi3If
 z+L9glJoQixnbqOXujcNRVBEK4Qw4+lKiUyDZZktw+Dt3IYFFGABNbyLUXVvGX9uAMf5Pl1QO
 wH6ufGt4S33v4jNqoCgB1tupMUFIBpzyk1KlrDkGpoSepxEUcsjmlG49zg0GJPFZQgktnNOqI
 n15KbrFUz9lcgrmkc3XYev+FYSscf4fz7Xx0wz8nDuSZz1wP50VgvCEZfdc2WJz5QExcdkvt/
 SPMcnltbrqIzNZKWlI6KG5i6Izx0EbNGanwmr3hV+GwBXQG6UCAVYerQpsjiCXxmuPmZkObPo
 kUgaqQL92e/fh8nfz2kY+vYMhYRub1pjUnrBK6AxlLzW9TYKGhpivCfyKW+fEyMNWzUHFLcQE
 kRzhaF0C+pU6ao1L8ZjBBcxqfEwLv8gl8rWeBLTETfHR9Cg/s1Z4Cmh/UkWzY9Y9qAK0bwD+T
 XHufLtdwl2lUHJNZ1NXFK5UnMnoNCpzHDP1LzY28NqbOiheQRG3r07hDOy3p/YypwqH1IaU0L
 34FotrFRF9fTb+SRSc0mRZoNnVE=
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 13 Jun 2023 16:57:55 +0200
Juan Quintela <quintela@redhat.com> wrote:

> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Lukas Straub <lukasstraub2@web.de>

> ---
>  migration/ram.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index e3ff98a6ce..293ea87a70 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1114,14 +1114,14 @@ static int save_zero_page(PageSearchStatus *pss,=
 QEMUFile *f, RAMBlock *block,
>   *
>   * Return true if the pages has been saved, otherwise false is returned=
.
>   */
> -static bool control_save_page(PageSearchStatus *pss, RAMBlock *block,
> +static bool control_save_page(PageSearchStatus *pss,
>                                ram_addr_t offset, int *pages)
>  {
>      uint64_t bytes_xmit =3D 0;
>      int ret;
>
>      *pages =3D -1;
> -    ret =3D ram_control_save_page(pss->pss_channel, block->offset, offs=
et,
> +    ret =3D ram_control_save_page(pss->pss_channel, pss->block->offset,=
 offset,
>                                  TARGET_PAGE_SIZE, &bytes_xmit);
>      if (ret =3D=3D RAM_SAVE_CONTROL_NOT_SUPP) {
>          return false;
> @@ -2025,7 +2025,7 @@ static int ram_save_target_page_legacy(RAMState *r=
s, PageSearchStatus *pss)
>      ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
>      int res;
>
> -    if (control_save_page(pss, block, offset, &res)) {
> +    if (control_save_page(pss, offset, &res)) {
>          return res;
>      }
>


