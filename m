Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E11394BE79
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Aug 2024 15:22:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc35E-0002yA-Ge; Thu, 08 Aug 2024 09:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sc35C-0002xg-KX
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 09:21:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sc35A-0005OF-Vh
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 09:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723123291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hoD6+q9lWBYV5Y2sZnVNVJtxg5xTJA0wa/FmI0JBJo8=;
 b=L7olHvBifpnKX74gzdjodkx7dp9mN7IeudTx3KVjvfvdO90b2gwMc6udJ/ooV2Z/7AoIzf
 vuYXtpvORCgCcBgwmAIgNOmAeSGjAWkRpqia8tbu/n5fWHm0SZh3jRimKx+1fSks065uu/
 23jYt1YsHHDA9i2EW8fwm/WXvqlxnhY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-XZO5YEC7O8eFwtnt1lRJag-1; Thu,
 08 Aug 2024 09:21:26 -0400
X-MC-Unique: XZO5YEC7O8eFwtnt1lRJag-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D5CA19775FB; Thu,  8 Aug 2024 13:21:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B1BF1955F38; Thu,  8 Aug 2024 13:21:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3E48B21E5E6E; Thu,  8 Aug 2024 15:21:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Shiju Jose
 <shiju.jose@huawei.com>,  Cleber Rosa <crosa@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  John Snow <jsnow@redhat.com>,
 linux-kernel@vger.kernel.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v6 08/10] scripts/ghes_inject: add a script to generate
 GHES error inject
In-Reply-To: <e9f2011095facb566815ccac13c9c87be710fa5e.1723119423.git.mchehab+huawei@kernel.org>
 (Mauro Carvalho Chehab's message of "Thu, 8 Aug 2024 14:26:34 +0200")
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
 <e9f2011095facb566815ccac13c9c87be710fa5e.1723119423.git.mchehab+huawei@kernel.org>
Date: Thu, 08 Aug 2024 15:21:21 +0200
Message-ID: <87ed6zup4e.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Using the QMP GHESv2 API requires preparing a raw data array
> containing a CPER record.
>
> Add a helper script with subcommands to prepare such data.
>
> Currently, only ARM Processor error CPER record is supported.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[...]

> diff --git a/qapi/ghes-cper.json b/qapi/ghes-cper.json
> index 3cc4f9f2aaa9..d650996a7150 100644
> --- a/qapi/ghes-cper.json
> +++ b/qapi/ghes-cper.json
> @@ -36,8 +36,8 @@
>  ##
>  # @ghes-cper:
>  #
> -# Inject ARM Processor error with data to be filled according with
> -# ACPI 6.2 GHESv2 spec.
> +# Inject a CPER error data to be filled according with ACPI 6.2
> +# spec via GHESv2.
>  #
>  # @cper: a single CPER record to be sent to the guest OS.
>  #

Accident?  Drop, or squash into PATCH 04 instead?

[...]


