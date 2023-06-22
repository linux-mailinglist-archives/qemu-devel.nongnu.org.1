Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C06DF739FB9
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:38:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCIcs-0000WG-AN; Thu, 22 Jun 2023 07:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIcp-0000VF-01
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:37:19 -0400
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1qCIcn-0003VQ-Em
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 07:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687433833; x=1688038633; i=lukasstraub2@web.de;
 bh=cE59X7NKhRulWMCjBmQtyOabcjj4P1/EccIuButKREE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=pg80FD0Qf0tX+h39Lg6ZKOcWu7ctKnW4ejqCS6rE5funiMoh2G6rWc1uraDYD5fZdU/Vnt4
 1z9FoWdrsPW33KLfASLFuJxS4t/egqMksgUCiNUFdOJXmlqYmilXMmdUFkijjEGx3Y+/a04wJ
 aCLVrhBrj4Pzr7Xb1AKwYI/FeN/+M93ph5zpGvgx85LzImE4n7yX2QfZlDrmZPYG+n9lwVBSD
 tL4JVH8lAx4xb5XEb2En+v/C/SyjbWJfiqhF95lP+Wm6Qgr6kZCSxoxNapUWKkrZHeNz3n6cm
 JSqGDtcHg68I6V+zoeqbg4M77hVv8z20aqHl96OZRb6GGIQzjfjQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from mobian ([46.114.147.93]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCoku-1qL4370BWq-008xz5; Thu, 22
 Jun 2023 13:37:13 +0200
Date: Thu, 22 Jun 2023 13:37:09 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 02/18] migration: Give one error if trying to set
 COMPRESSION and XBZRLE
Message-ID: <20230622133709.64def12d@mobian>
In-Reply-To: <20230613145757.10131-3-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
 <20230613145757.10131-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kebkr5nD+DGBSxoTEXLeY/oh+1fOVyYxsQ0Tpsa5Kh4yWUpDf20
 VsnV1YhcSdrBqmK4u5FcFWanntFM+V3PsOJb2iyNQe7VQZ/8X9hTnTIVDZjqIQjo6BHAgaX
 kTOr/i55uTc9sQSqH6iJWZC6j4lRAhrjPHf7q4sD+Jaqx0/X0VPSPPjbz1QhlVZm8PYXW26
 Hnyf3d0Jb9BSHww3inlDg==
UI-OutboundReport: notjunk:1;M01:P0:H0NNc3/rN2k=;DB+jRKjFKEB/JNIqZeAcncD3Hrr
 O/AxSEQchZqLd+/BwkEfNZQG6E6Ru2YYLiw2mq9i9eYOs+VgwsNIEZLgIX0WH6uwZcN4IE2rP
 sQk427lOlxVZ/whoKGtbkmRJcOXlwGpmkWDgY4OFBXtDM8RBHy0oO/jhT/GlmnEXEcyHAHFJR
 7TgZ6E1pjDbBOpw91ngmd6jjfb6ZJUqZ7x2HxTL8HrmuYk5xtzALS8Tn84ZFNyJ50et7rLRsZ
 I2xXDgs/3fPid774TaBYmDZa/SKdsu65tOXLMVjPaGf50ZQE4dLXXRNez/UYKKIxHQmkP63Mq
 MIhUuMExSlokOn9xANSLx2GeWCEvQElIHvpikGxKpIXfw9k2Q+cmjVnPTlB+lawi+AvZR4RI0
 rJVXdzxMcKs0Y3WwnelSPJYzi+k4Ru6RKV4GjSSF4ihk7HovEUT7XJNXjtuDFafCN5+l5SbAc
 yn+RnzGdc0M28ihepA7/wtnIkxnzu+gbW/uA2Uc1Mi1lGVuNRKaqNWN1PFwq+3Cqad1XJhQiq
 XQi+Jm5xs4C+N/l8yJquqcyZWyYen8+uo+DxTj6CjDr8YsSIFeCIDcnchPo1f7YP7HeAvFInb
 riiFeh6MA4ZlzmOBgwbbtvDwYRC1SyLKqAkr8ze6lL5A4Nuq5SVToZfiF2dxnLOPT1zLDEW2p
 8Dzy0j7h5M+o56/qu8V9lfqnFqR6zbOHOFkRRauWDsTsFCE5JUq+RPauZAHDqvEhqAP1DXxgP
 xa3X2nrf46aF9z7j64e1twB57njv74W9VovS9dzZ/XblO70ya5RwVEnKOqJ5sJATt0CF0/m8A
 dyXjHGX32Fx6Nh3x6i7rng0Me2xVMvPR7KJ6Jdp2aTGryGU1sVhc8Dvd4N67JhAGb8zoPaFLb
 q/MhHZCYH2htKOld6PyDiU8z6s0cYMKI8S+cjSd1kFXjjcEYfVPsxJ1zV0EkUZ13hFVav+9Zk
 SiOecxSW6rCOcj3ShTZVXFl2Crg=
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
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

On Tue, 13 Jun 2023 16:57:41 +0200
Juan Quintela <quintela@redhat.com> wrote:

> As we have disable to use both together in the previous patch, we can
> remove this check.

This commit message is off.

>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/options.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/migration/options.c b/migration/options.c
> index c6674a4753..a18689c314 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -554,6 +554,13 @@ bool migrate_caps_check(bool *old_caps, bool *new_c=
aps, Error **errp)
>          }
>      }
>
> +    if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
> +        if (new_caps[MIGRATION_CAPABILITY_XBZRLE]) {
> +            error_setg(errp, "Compression is not compatible with xbzrle=
");
> +            return false;
> +        }
> +    }
> +
>      return true;
>  }
>


