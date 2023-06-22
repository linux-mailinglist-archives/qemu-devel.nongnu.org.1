Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 466DB73A002
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:47:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCIm5-000709-HJ; Thu, 22 Jun 2023 07:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIm2-0006xq-GA
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:46:50 -0400
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIm0-0004xx-OW
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687434404; x=1688039204; i=lukasstraub2@web.de;
 bh=yGhmJ1K12w/Tj+TnQAKV5jtw2Un4GNBao5nuhDHYhQs=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=i0iSCAm/LdWvHS+/GnMH584upIAUVabS65mnJbHiYtQXcj6rIjFt6+Rz2giiP8k3wI+7E87
 D64LgtnfGRo/yrVyBh736fwMaHm9nGvyUf/9WkTioILXr1clHigs/PLzFXGQM89MIhb3sElw2
 XJIKU1V4iGT1mS0NxBdQ9Kwb+tsOEzY9FBVe5mpXwjL+f2ANqpGLGx9YJs6uYYp5FcInfhRpC
 psQrxSRNjkmAred2rn5aBJI0T27pQ06WF6t4DNEMTRrf9C9EcWQbNW2Ysu2CXl0jPH2bcrvEf
 2DNUsg2QEf8o05mgCXTncntUZ+QSGC4zxQEfvmCEvrnIZ4cSS1jg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVad4-1qbd8y2h7M-00RxVq; Thu, 22
 Jun 2023 13:46:44 +0200
Date: Thu, 22 Jun 2023 13:46:40 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 11/18] migration: Move busy++ to migrate_with_multithread
Message-ID: <20230622134640.15fa8b9c@mobian>
In-Reply-To: <20230613145757.10131-12-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
 <20230613145757.10131-12-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jra7JkWEyNU_fK1Upz9VaC9";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:oVsYvOzLnEBBQkYvjy55axCy4gezauDbiY+J35N45VEVw4znrPB
 XoRKcXFu1Wtbu7kSqHIpCQ/POedDRF+1PV6I7O70Y+uC9txG7kl4iNowBYHwAM2HT4h0YzA
 YdkQwY+w/WNctx4V6ts68ow57CCEy1rJTAbY0xqOW/UFUUChaeXiSZ7zWmgz5bCX3587UdA
 cYUcxI5G5p0raWYH6IwGA==
UI-OutboundReport: notjunk:1;M01:P0:pO4XumK+4aM=;HRN9TnPvcZ8T7GLRh7oDFLlD3h2
 UkX3yEeQQEwh+9LPjj5dlpTqMo3UrUWcJdisX0PuEDkLsenyd6+bn1EOUhXCZ2TcCPsOlbHKD
 pOaTjQ/xxQTZcV/DkgUQ5oceeXqsvo+h0zoC8m7ImMaiLUIbNMJjQHKK+kBQst+e5WNwOKG5u
 a96jAF93hEiF+PVVORAXRQ92JFaiAua8u91tGghzHVxmRp4JvLtA1NrL13NAxiH0gJcZ2WYv8
 Qklobl0nWZy+76IaLAG8DWtVJyUrv2ykp+jc25OJL4BxS7SHXse4Rj0qWqtUhxVPt1RbvEUMi
 CtwWGTWz/Nhbr3lMZVcPLtzWO09eNBUXJvIJ5z2V5/elINegnND0w5v2I7SUs9ttHqnrRY1bs
 w8GW3i3UOigqiV9H4U8CzCPPUa+T4IKfFJQqThCz0gLWijVL9Ly+ja+9aon96jUWXcMnrUgH2
 kWpLVcvyuC6cr9V2wRj0hz9gd+SLzXPsrB/D6e3UcC35rPCsy8Nqg38iEt5sT/QhtaNgeYMCT
 XK4a1N4SKR54HjmfvYtTuYAnId0ywDQD2vSlG+AUmGIL9HkhllyqVOxPCJnzRdK1sxxrDQQ86
 cKXSOPrnf45cO/7RvVp7imT9UwOM7SRxU4OSkAnPRyPW5YosTt76nNL6JYytQW69HLClVojZH
 +q1RWC2ut8lC37supjsg2XQMgGp52WUiMCuK1AHaEFvmnqgGfItfdoLKH57XTVCYu9bW2Mc+r
 NdnaAbB8IpGMvk/RPKvwoMx40lva/bxsBujHsalIyU9aNfd/rbie8+zd8pAWxaAotjGkksvHO
 PHKuueu0uQbwAuok0wAt+Qum5PYmcq1Z/QBaWbf8ozTVcmSB+0tuzqInHYb9uk6Ab17UkFjKW
 AHKycD9Or+ybY1ShI+oWp8Jwt9vmNmlW8YwPhMd4AQR71iRrkSqCuf/HXA/Z13UT03/xd4u2L
 pHKcOG/Pl4yHAeYEyuhV8MBomKk=
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--Sig_/jra7JkWEyNU_fK1Upz9VaC9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2023 16:57:50 +0200
Juan Quintela <quintela@redhat.com> wrote:

> And now we can simplify save_compress_page().
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Lukas Straub <lukasstraub2@web.de>

> ---
>  migration/ram-compress.c | 1 +
>  migration/ram.c          | 7 +------
>  2 files changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/migration/ram-compress.c b/migration/ram-compress.c
> index 3c44803132..2652cdee8b 100644
> --- a/migration/ram-compress.c
> +++ b/migration/ram-compress.c
> @@ -293,6 +293,7 @@ bool compress_page_with_multi_thread(RAMBlock *block,=
 ram_addr_t offset,
>          }
>          if (!wait) {
>              qemu_mutex_unlock(&comp_done_lock);
> +            compression_counters.busy++;
>              return false;
>          }
>          /*
> diff --git a/migration/ram.c b/migration/ram.c
> index 2a3ff2c36e..60f24006bc 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2034,12 +2034,7 @@ static bool save_compress_page(RAMState *rs, PageS=
earchStatus *pss,
>          return false;
>      }
> =20
> -    if (compress_page_with_multi_thread(block, offset, send_queued_data)=
) {
> -        return true;
> -    }
> -
> -    compression_counters.busy++;
> -    return false;
> +    return compress_page_with_multi_thread(block, offset, send_queued_da=
ta);
>  }
> =20
>  /**


--Sig_/jra7JkWEyNU_fK1Upz9VaC9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmSUNKAACgkQNasLKJxd
slibgBAAnl3dfvW+7/2VnFA2/T8SfPmLLp8dDLhJykZ+KNvpF0b37W1nUBv+nL4D
ltZXfBDW3ZZZeigNAGpPpEIFzzm/+KgKSVN/b/zs9fadQUbqwuTHvGolRxNkgv8H
IZblgi7JtA7OyEA+sv5Ai8Fb6S/yR5sKmjNDV/s1jB/6XToAcs2Dk+KRjJCH8KjB
LN+3LTQFiaRKaWN/xIDVtTTK7fouZtah4LnV7PcbycGdDuZjdWDai/Wng0rpwC43
rFraK/NxIOderclYZFvFosug8ypngu03EGuZEJKurCNwFJLBcMs2S5mUH1ON/yNM
0FMXvZ854lljJH2P1Jsh10N5m6CwwXv9thY+sjheuQ0+ZI5TsiK0b7DnS7Wws6ZK
wwGKrJFJ/skWfxdroxnNjDnv+1JVi8/oRgSpZQ7jbkkAvLe4vnyVMLcLus60h6tP
c7Vl7cwhIIQrrRFLzSvxA+aOJDMRoeHoCHAVus0ZLQnqBW5khVmR03xK/1k6Tcmm
3KrE4aWg7D49SmNyDSwGQ6hg7U6tUw0dtvFu5fOgvp5Hr4l5UJqV/5qIP3yIbijV
6mAZxRNIF+5ro8ki+uBfAXeGk1cp50Kkrmwa4JCYF6WIXwYV2H8rcr1qMsgMPJCv
8xvAsM1TXseeYdVFsYzo1inae/xplPrjdfpfH6XFK+ellTqMlTA=
=RD2L
-----END PGP SIGNATURE-----

--Sig_/jra7JkWEyNU_fK1Upz9VaC9--

