Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A1E76D835
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 21:54:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRHv1-0004cM-Jg; Wed, 02 Aug 2023 15:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1qRHuy-0004c1-HQ
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 15:54:01 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1qRHux-0002Vx-08; Wed, 02 Aug 2023 15:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=7MJ6jFozg6Jt+lEkJoF2qyq3O4LOyFovh2pHT9lFuz8=; b=qTOMX4ymUG7AKiJjAvHv
 MgUSvMBE5R5e3MW/is+PUS/5wMo/fsoy4O4ECNPHSEh54IViRpzVg0XZGInltB/B1/UGod4tZvtFe
 k40npxcZcZsf5kY0ln8hBtkpYnGZ9BJ5kDwB8O0pWhew2CJ4WBmt13f6WNrrboHv6/w6QAvmdb7zp
 4nCFPvrz7Hs1F+yofsWUh+gtOZxBoC7+GR9XH4xn0P6WlX4gFgtOdd3Fr0fx5zolPfkn9/LtqWL7d
 0hMw2TZhhvzarWLfsljjzw58wb/1GDSKyY2O9F4Xv/DeEmTx3JQK4pITcZ34wGWJJLfR24WZUsl8Q
 BFl/SQtrtsjh8g==;
Received: from [2a01:cb19:4a:a400:de41:a9ff:fe47:ec49] (helo=begin.home)
 by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1qRHuw-0002oJ-Oc; Wed, 02 Aug 2023 15:53:58 -0400
Received: from samy by begin.home with local (Exim 4.96)
 (envelope-from <samuel.thibault@gnu.org>) id 1qRHuu-009e8g-0z;
 Wed, 02 Aug 2023 21:53:56 +0200
Date: Wed, 2 Aug 2023 21:53:56 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Henrik Carlqvist <hc981@poolhem.se>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v1] Allowing setting and overriding parameters in smb.conf
Message-ID: <20230802195356.rwibjix3bub7s7qw@begin>
References: <20230608181439.7ea3a5c5.hc981@poolhem.se>
 <4e8f027a-ca00-c54f-ef2f-f0df1f5b2f9e@ilande.co.uk>
 <20230610122912.0fc157de.hc981@poolhem.se>
 <20230611014751.22f22674.hc94@poolhem.se>
 <ZJFv4Hq8RMVOUum/@redhat.com>
 <20230620215043.6124c450.hc94@poolhem.se>
 <ZJKiGBJNQa5Kx+Dg@redhat.com>
 <20230621201447.712ec73a.hc94@poolhem.se>
 <20230623203007.56d3d182.hc981@poolhem.se>
 <20230801232725.4cc838fb.hc981@poolhem.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230801232725.4cc838fb.hc981@poolhem.se>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
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

Henrik Carlqvist, le mar. 01 août 2023 23:27:25 +0200, a ecrit:
> @@ -950,10 +953,11 @@ static int slirp_smb(SlirpState* s, const char *exported_dir,
>              "printing = bsd\n"
>              "disable spoolss = yes\n"
>              "usershare max shares = 0\n"
> -            "[qemu]\n"
> -            "path=%s\n"
>              "read only=no\n"
>              "guest ok=yes\n"
> +           "%s"
> +            "[qemu]\n"
> +            "path=%s\n"

?This is moving read only and guest ok to the global section?

Samuel

