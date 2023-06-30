Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CAC743AE2
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 13:33:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFCNE-0001Vn-P6; Fri, 30 Jun 2023 07:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qFCNC-0001VT-19
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:33:10 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1qFCNA-00084g-0A
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:33:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1688124771; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=cRcjtAI/VOG4+GoSH9C6eYFR+KTj/0suAWOkzfHgw1F7QpXsrqGMdD/SpNzFmO5wso
 mvWJRlxXMDh9Ae09lMsj1cDB3o3R9pXdC06gQPl8IwfVmrA1pKTe8wrMuUfiRpagfBSG
 euMRvIw4YfxaWcJkRnqSlLzs365RGN8mD3k71YLEyAplZKe7GNxCmDwQJDwKbwrn9N4f
 AjAN6Zu8qUOcGF07MmpZ4swbZTMIkp33cVHLP2xUS6Y+gJCvgqsjzqrSgw9ArLDViyX7
 ga9xDpIYqhBhAlFEfPQvNom0Uflmt6ZaIhGSl7uftKn2QBWS2sGEImb81CTBcN1hvXhH
 Vmlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688124771;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=/gk7lMpgzNECZCi+/gCLLwKmUN3PQkb6jMH9TC2m/MQ=;
 b=a7+sFiEgWoGvMgdiSq+qGYdiqYp2/RLHA6/cJM/4muZ5zWLijBe8ASnOPp4ii2uIjV
 sayusVaiYLrdFOb4P+mmzOJmO0MvC+iNHhY3pMbMuHnNpryw+cvDBFlb2OWVEj+WThCQ
 m7mwTaWKc/0gQYZ4o62NXUI477OnhE+7KlsV/t4m/CN9NTOnok33avX6P6OoWdQE/JgT
 6rdHmZ2zgbSnszNBQziljCN4k1o1/+tKeO+eNkAVaKmMgc2PlJ4qpqn+yvvBxxlj89UY
 0XxNoFJfoZ1XvWuYFlmaNn9GI8OkiSfKzNyzlmuc7Hdi30xKhH1eaM/UhgsPNJMeUGmY
 0L+A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688124771;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=/gk7lMpgzNECZCi+/gCLLwKmUN3PQkb6jMH9TC2m/MQ=;
 b=fYBN01q30vZeqh2Frh9iN/k7steP4RJ2Az4vC1H/ZAFrn6NrnnpBDKy1UY8IQYYAZ3
 z6YbnP5TsXsS+MujV478r/Dj6D7LXM+zikAjmQnWM+fReZCXHKVo0Rg2hFuS+wUD/fnw
 KjoEB9WSj9NgNgnCr9ryWbm8oRoZI0yv85nooLUwOqmmm/+x3DAyGmwcnhomgiYzDbli
 wksRGExpHZTv2ld5iDbVYukb0+Yja40kBzp/uzJtxQKt0RdtSD5d1EeGe4MYq12skQlQ
 AdVLvNap7x9Zc9C22KzzjTmEbprXUyNWE3CdjX+1Vh5MWuqimfUSY2g1fDFoUQg8UR/Q
 gc+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688124771;
 s=strato-dkim-0003; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
 From:Subject:Sender;
 bh=/gk7lMpgzNECZCi+/gCLLwKmUN3PQkb6jMH9TC2m/MQ=;
 b=hEf6aYcS9lS1cIrxjvszx8GUI7WptFij09TxonfrZJm/Xt6yRBByhoEi2TfJpIKat5
 3LgbSlsr96ERdDYZbbDA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4VReIOE3s+xIC8HZ8TOtjelmE6SkKgUS6xMby0Q=="
Received: from sender by smtp.strato.de (RZmta 49.6.0 AUTH)
 with ESMTPSA id y5401az5UBWpyNP
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 30 Jun 2023 13:32:51 +0200 (CEST)
Date: Fri, 30 Jun 2023 13:32:42 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, John Snow
 <jsnow@redhat.com>, xen-devel@lists.xenproject.org, Stefano Stabellini
 <sstabellini@kernel.org>
Subject: Re: [PATCH v2] piix: fix regression during unplug in Xen HVM domUs
Message-ID: <20230630133242.58e6d9ed.olaf@aepfle.de>
In-Reply-To: <367317C5-DB65-40EF-B45B-97E0E802A994@gmail.com>
References: <20210317070046.17860-1-olaf@aepfle.de>
 <4441d32f-bd52-9408-cabc-146b59f0e4dc@redhat.com>
 <20210325121219.7b5daf76.olaf@aepfle.de>
 <dae251e1-f808-708e-902c-05cfcbbea9cf@redhat.com>
 <20230509225818.GA16290@aepfle.de>
 <20230626231901.5b5d11c1.olaf@aepfle.de>
 <c939b695-2b68-085a-0f19-108ecdcc1a05@redhat.com>
 <5DB37FA5-41DF-4ED6-8C8A-CDDD6F276F42@gmail.com>
 <20230627140740.2736f6e8.olaf@aepfle.de>
 <4F5609FD-4A89-4450-89E2-3311CC5A9317@gmail.com>
 <20230630092921.392b302d.olaf@aepfle.de>
 <367317C5-DB65-40EF-B45B-97E0E802A994@gmail.com>
X-Mailer: Claws Mail 20230601T090920.68bc28c0 hat ein Softwareproblem,
 kann man nichts machen.
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WOYyKbs1pq2/gEoXAojnkkq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=81.169.146.219; envelope-from=olaf@aepfle.de;
 helo=mo4-p00-ob.smtp.rzone.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
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

--Sig_/WOYyKbs1pq2/gEoXAojnkkq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Fri, 30 Jun 2023 08:05:29 +0000 Bernhard Beschow <shentey@gmail.com>:

> Yes. Have a look for piix3/piix4 here: https://www.intel.com/design/archi=
ves/chipsets/440/index.htm

This is hidden behind a login or whatever.

I should be able to come up with a commit message without hardware specs be=
ing available.


Olaf

--Sig_/WOYyKbs1pq2/gEoXAojnkkq
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmSevVoACgkQ86SN7mm1
DoAoiA/+Nac1y4FAslYKcs5MbXKeAht0YipykhnZnjEs5GFr1xmFi8cKvrPrzyaB
EYjjXoosax8+YJJM/GDKaXyHx68piIf5YdMvA8Zdkp4mQ+HuAZIQa0zit9ONA+gS
WHs154Zf/RqcQMVDjf74GcptgPP2YOmc/MPbZ6UV3GhXD+irdu8bqBnBeNqOV69q
w/irUkAV/tBym8DHacToeoD0KB7c/aGq/6SJHlDSCYcWJElG0midU5E5dMPzNEGz
+w97vAZ6LHcM0NVfa/lwUiXEntM6rDpPNwTyCP2todWEfUZsT+Jn8s8q+H8R6r/O
5FIXltIRH/fl5TEIJsYYEyWYWM4cMxhcVGuTJSeNI0mjxMgqg1OMrg25YgZUNKFK
qmALpYbLZkcLPzIG9YMFwEwAUTdU3zVCinTmuhfTUQc/SStu1I6j7UfVSmSZaScx
sOEWkXzRlr5MbUt/HZ8NTjI2FA+WW3CF428nNFdz1Un+l7Ftq61wkDzsfJ6G6Rqj
xQPe9W98WmaORotynCq+itxUHEzJVFXgG92Lf6/zihB4bqGZes/LXT7NiLRUUUq0
73EOEMZ4fQuxHhsuC0M/S3UeF9I43ONbgAwksZSBOQZY8q6hnTGH5vSvzf8igd0Q
swEhq8zVVLlvihWAHLqx2Ck8LZO8CIFRzBz/0hAHHzCJBC0QQYU=
=8PAh
-----END PGP SIGNATURE-----

--Sig_/WOYyKbs1pq2/gEoXAojnkkq--

