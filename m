Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F13E68B042F
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 10:21:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXsE-0002LL-3f; Wed, 24 Apr 2024 04:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzXs5-0002DT-Bp
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzXs3-0007Hh-Aq
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713946850;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=zb0ZY/OtYGFlhwxIfsFFVt97Rf7DxPQlwIUFJI/IxCQ=;
 b=T3HrU0RBxMRlsHajkG7EPmHGsa0muwpAelTdUsz2a1fXZhftCBOI87CM6oRy4Qg3amxUto
 uu7aGylHSIc36bkhjE0aSYjj5JTRPSaWrhXugLkRlF+8RFD11+T3zywI9feSXA17JZ8Fsk
 kL+pm/Z4MC3t6tHP1UNqb7lE3XLAY+U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-E4cCnN1INjesGt-cIDbUXQ-1; Wed, 24 Apr 2024 04:20:46 -0400
X-MC-Unique: E4cCnN1INjesGt-cIDbUXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE0781011A14;
 Wed, 24 Apr 2024 08:20:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B0222166B34;
 Wed, 24 Apr 2024 08:20:43 +0000 (UTC)
Date: Wed, 24 Apr 2024 09:20:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com,
 david@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, armbru@redhat.com
Subject: Re: [PATCH v2 1/3] cpu-models: add "disable-deprecated-feats" option
 to cpu model expansion
Message-ID: <ZijA2XFbPwxi0F4h@redhat.com>
References: <20240423210655.66656-1-walling@linux.ibm.com>
 <20240423210655.66656-2-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240423210655.66656-2-walling@linux.ibm.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Apr 23, 2024 at 05:06:53PM -0400, Collin Walling wrote:
> This optional parameter for query-cpu-model-expansion enables CPU
> model features flagged as deprecated to appear in the resulting
> list of properties.
> 
> This commit does not add support beyond adding a new argument
> to the query. All queries with this option present will result
> in an error claiming this option is not supported.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  qapi/machine-target.json         | 7 ++++++-
>  target/arm/arm-qmp-cmds.c        | 7 +++++++
>  target/i386/cpu-sysemu.c         | 7 +++++++
>  target/s390x/cpu_models_sysemu.c | 7 +++++++
>  4 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 29e695aa06..b9da284d2d 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -285,6 +285,10 @@
>  #
>  # @type: expansion type, specifying how to expand the CPU model
>  #
> +# @disable-deprecated-feats: include CPU model features that are
> +#     flagged as deprecated. If supported, these features will appear
> +#     in the properties list paired with false.
> +#
>  # Returns: a CpuModelExpansionInfo describing the expanded CPU model
>  #
>  # Errors:
> @@ -298,7 +302,8 @@
>  ##
>  { 'command': 'query-cpu-model-expansion',
>    'data': { 'type': 'CpuModelExpansionType',
> -            'model': 'CpuModelInfo' },
> +            'model': 'CpuModelInfo',
> +            '*disable-deprecated-feats': 'bool' },
>    'returns': 'CpuModelExpansionInfo',
>    'if': { 'any': [ 'TARGET_S390X',
>                     'TARGET_I386',

I think this is an odd design approach. Lets consider the
current output:

(QEMU) query-cpu-model-expansion type=static model={"name":"z14"}
{
    "return": {
        "model": {
            "name": "z14-base",
            "props": {
                "aefsi": true,
                "aen": true,
                ...snip...
                "vxpd": true,
                "zpci": true
            }
        }
    }
}


If we want to inform a mgmt app of some features being deprecated,
why not just unconditionally include that info in the reply thus:


(QEMU) query-cpu-model-expansion type=static model={"name":"z14"}
{
    "return": {
        "model": {
            "name": "z14-base",
            "props": {
                "aefsi": true,
                "aen": true,
                ...snip...
                "vxpd": true,
                "zpci": true
            }
            "deprecated-props": ["ppa15", "ri"]
        }
    }
}



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


