Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B01A7CD985
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:47:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt45O-0001Vx-A3; Wed, 18 Oct 2023 06:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt45M-0001Ty-0f
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:47:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt45K-0006Ce-J3
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697626049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fWUgdy5s1LBxAuMgojeRfjiKawmdIIoxhwyqq/gk/48=;
 b=Exe5lu6oIWX0TpMYx3HI8JJY7FT//JvuoNbcY6+1u5Ihc0OXYqfHUcUFuuUZhKk6IAChXN
 qbo3HRDLZrXGB5VupTn3H4IU1upokArD1q+DEM5PkToCZEhIwU8STrqAYlsbChnbjBBKdV
 Chpca0S91a1R8y061qcvkxlLNpLxBOw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-UT9vlkl8P1m32z_b3lZIqA-1; Wed, 18 Oct 2023 06:47:28 -0400
X-MC-Unique: UT9vlkl8P1m32z_b3lZIqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 943C1185A7B5;
 Wed, 18 Oct 2023 10:47:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3740D2026D4C;
 Wed, 18 Oct 2023 10:47:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 41DC221E6A1F; Wed, 18 Oct 2023 12:47:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 philmd@redhat.com,  peter.maydell@linaro.org,  eblake@redhat.com,
 maobibo@loongson.cn
Subject: Re: [PATCH v1 3/3] target/loongarch: Implement
 query-cpu-model-expansion
References: <20231018085908.3327130-1-gaosong@loongson.cn>
 <20231018085908.3327130-4-gaosong@loongson.cn>
Date: Wed, 18 Oct 2023 12:47:26 +0200
In-Reply-To: <20231018085908.3327130-4-gaosong@loongson.cn> (Song Gao's
 message of "Wed, 18 Oct 2023 16:59:08 +0800")
Message-ID: <87zg0gryv5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Song Gao <gaosong@loongson.cn> writes:

> Add support for the query-cpu-model-expansion QMP command to LoongArch.
> We only support query the 'max' cpu features.
>
>   e.g
>     start with '-cpu max,lasx=off'
>
>     (QEMU) query-cpu-model-expansion type=static  model={"name":"max"}
>     {"return": {"model": {"name": "max", "props": {"lasx": false, "lsx": true}}}}

Suggest to show what happens when you try to query something else.

> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>  qapi/machine-target.json              |  6 ++-
>  target/loongarch/loongarch-qmp-cmds.c | 64 +++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+), 2 deletions(-)
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index f0a6b72414..752b18cced 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -228,7 +228,8 @@
>    'data': { 'model': 'CpuModelInfo' },
>    'if': { 'any': [ 'TARGET_S390X',
>                     'TARGET_I386',
> -                   'TARGET_ARM' ] } }
> +                   'TARGET_ARM',
> +                   'TARGET_LOONGARCH64' ] } }
>  
>  ##
>  # @query-cpu-model-expansion:
> @@ -273,7 +274,8 @@
>    'returns': 'CpuModelExpansionInfo',
>    'if': { 'any': [ 'TARGET_S390X',
>                     'TARGET_I386',
> -                   'TARGET_ARM' ] } }
> +                   'TARGET_ARM',
> +                   'TARGET_LOONGARCH64' ] } }
>  
>  ##
>  # @CpuDefinitionInfo:

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>

[...]


