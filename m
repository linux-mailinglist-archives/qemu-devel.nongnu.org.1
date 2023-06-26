Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DCF73DCC1
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:03:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDk00-0004ye-Pz; Mon, 26 Jun 2023 07:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDjzs-0004wi-Iz
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDjzr-0005pp-4g
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687777382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RSbelXSGkZatYXZTq1CoarB3jMapbBN0ctpePyJCYWw=;
 b=LM9ATc6FktUtyyAEq0CiklyOPqztqKiVdDuAhj5X5aED9grKZ8rziFL5eaYO3jMeXnXvQt
 9Rv0SXaVgJQuDujdHjcWSBsolFOr9sf1oduqTYlxL/TFWN5mqBzlenEyAMDeRzX5KfnQEs
 1GGXR2L+eg0I/p+rTGjbmnx6D2e9NRY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-A30KB7bUMl2QNXE7WfOnNA-1; Mon, 26 Jun 2023 07:03:00 -0400
X-MC-Unique: A30KB7bUMl2QNXE7WfOnNA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-987e47d2e81so248973666b.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687777379; x=1690369379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RSbelXSGkZatYXZTq1CoarB3jMapbBN0ctpePyJCYWw=;
 b=En2fwFCSQ1DoMyu2ktd2KxT9NjUi1NBToUqhWZqdmxcFHlcR9/pl6YQE6thassMEBt
 gedjAfFAoHpeEAk6b0a9hAZhiMwIhoZ8A5H+aFYL/vjmDsb2KP2kPJ0MsLWG49yk+dD8
 R9kCLDnVrJy5hdHJpD1vBTG+j6cLK49d6ubbwMpi9V0XGwrSeFVGxJp+1JXeHi7pzHgG
 HhhiE+b32x+aoYHSVDuHgqPhf4a5DsSXMHXkKd5EVWIHmWzGKy8QTYdOh5crTrSjv8aM
 vizCOuD3OtyxLlG91Xt3R5gw91nar1PDmSJSdwkGIIDaNOysMiPujB1zkwt12eZrsBJj
 DXdw==
X-Gm-Message-State: AC+VfDxtnsVyV9LzyluRorzP+mZ8kMKkTjeGl2VZpFgaUVNkhOe1CVkQ
 vajBW0maExAt2Kf8Arg5hW0ju9V1JWGw9wX13hCaemI2/W9BIsmAa0n3sBVqzzoGeV11GNmtUEa
 yR63MVoMipCg/6Yk=
X-Received: by 2002:a17:907:745:b0:978:928:3b99 with SMTP id
 xc5-20020a170907074500b0097809283b99mr24146084ejb.46.1687777379582; 
 Mon, 26 Jun 2023 04:02:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7VHt9WgETP7RZqO623bkejnUj1iiZAlJpU909VlhcUydZWDAnocWj5D5jQEfpnHqmAirmq4w==
X-Received: by 2002:a17:907:745:b0:978:928:3b99 with SMTP id
 xc5-20020a170907074500b0097809283b99mr24146075ejb.46.1687777379388; 
 Mon, 26 Jun 2023 04:02:59 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 l24-20020a1709060e1800b009783791b1a1sm3107948eji.121.2023.06.26.04.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:02:58 -0700 (PDT)
Date: Mon, 26 Jun 2023 13:02:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] tests/acpi: allow changes in DSDT.noacpihp table blob
Message-ID: <20230626130258.6a4e5f75@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230621140723.462220-2-anisinha@redhat.com>
References: <20230621140723.462220-1-anisinha@redhat.com>
 <20230621140723.462220-2-anisinha@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 21 Jun 2023 19:37:21 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> We are going to fix bio-tables-test in the next patch and hence need to
> make sure the acpi tests continue to pass.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..31df9c6187 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/q35/DSDT.noacpihp",


