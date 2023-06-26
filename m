Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BF273E0E9
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:43:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmVF-00085q-HZ; Mon, 26 Jun 2023 09:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDmVC-00085f-U2
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDmVB-0003k9-CJ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687787012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vWc8G89X5Eh/bGYQWX+/pk0R9UU3KpM6XJG0IVz62RI=;
 b=b9c+QR+PY9LD4T1W3BZgzg0eoiD5eW/cxqKQHPshxQPUI0IvwyPa5EykH6+UhkuoMg0KyG
 kasFFCY58XwQoZep7J8bJ5g+QmfmiJ/vyErSmhy6L27Gp9v90QLuvBq7OEIgRjAUeQGtmd
 vt3CApW0bj6+auTEkqeXOH+ZbQyYpa0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-bedyYlVnOUqIV9NkG36bfA-1; Mon, 26 Jun 2023 09:43:28 -0400
X-MC-Unique: bedyYlVnOUqIV9NkG36bfA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-987ffac39e3so222253666b.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687787007; x=1690379007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vWc8G89X5Eh/bGYQWX+/pk0R9UU3KpM6XJG0IVz62RI=;
 b=XCWh6XdQVPQzL+u51uzBn2+6H4akkU7hPN/IlC+GTJyVnCQenGUu3QB0XyUKfMo7X+
 YShd/J0RjxnNhm4Z9cMZtB0AYB2s2GNmYZhtWwLpvHOmwFZggj7pjDNSgFyirGsT35CU
 FHwYVKJlz63W8Dv0ZCEzlmgoDKLR0DOBdPr933EP3rrGl3XUvqVjIlZhYOoa+Si7YH3v
 Slljsagk320QOs37HskRAsiVRQ5fMCAwNwuq13GCMGalsi8bOL1i551WbaKSwkbAXoix
 mN6dt0RJqTMXi5H163tuVghasayV6D/X3R1LNM2Rj7A9BA0okbH2rLKrdEnq7PK8T5Zu
 Xunw==
X-Gm-Message-State: AC+VfDxgYOEhmkoRjQ4LxqBrWyYYH9ISKg3yx/1hfkRS0Z7NpY0flXVd
 x3bOjlF/3K7/zArWh1W4INcxMhE+MvnR4iLg31E4cHjZUkIwJ1kUTLJZsfj+f+1CYPQzfgFcKG5
 Fo+rhXoF5bvWKQCE=
X-Received: by 2002:a17:907:3e87:b0:991:f427:2fe8 with SMTP id
 hs7-20020a1709073e8700b00991f4272fe8mr480006ejc.2.1687787007528; 
 Mon, 26 Jun 2023 06:43:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ65gcK0t+cccsNlUktpjDKWFdTL210OfGnXHGFHi/it+PQXajv5jyEm+Df/WXGwj/dSpngV5A==
X-Received: by 2002:a17:907:3e87:b0:991:f427:2fe8 with SMTP id
 hs7-20020a1709073e8700b00991f4272fe8mr479991ejc.2.1687787007273; 
 Mon, 26 Jun 2023 06:43:27 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 l8-20020a170906414800b0098e2969ed44sm2257896ejk.45.2023.06.26.06.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 06:43:26 -0700 (PDT)
Date: Mon, 26 Jun 2023 15:43:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0?=
 =?UTF-8?B?aGlldS1EYXVkw6k=?= <philmd@linaro.org>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 1/4] machine: Add helpers to get cores/threads per
 socket
Message-ID: <20230626154325.28697e88@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230620103958.3907565-2-zhao1.liu@linux.intel.com>
References: <20230620103958.3907565-1-zhao1.liu@linux.intel.com>
 <20230620103958.3907565-2-zhao1.liu@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Tue, 20 Jun 2023 18:39:55 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> From: Zhao Liu <zhao1.liu@intel.com>
> 
> The number of cores/threads per socket are needed for smbios, and are
> also useful for other modules.
> 
> Provide the helpers to wrap the calculation of cores/threads per socket
> so that we can avoid calculation errors caused by other modules miss
> topology changes.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> v3:
>  * The new patch to wrap the calculation of cores/threads per socket.
> ---
>  include/hw/boards.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index a385010909d5..40ee22fd93e3 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -384,6 +384,18 @@ struct MachineState {
>      } \
>      type_init(machine_initfn##_register_types)
>  
> +static inline
> +unsigned int machine_topo_get_cores_per_socket(const MachineState *ms)
> +{
> +    return ms->smp.cores * ms->smp.clusters * ms->smp.dies;
> +}
> +
> +static inline
> +unsigned int machine_topo_get_threads_per_socket(const MachineState *ms)
> +{
> +    return ms->smp.threads * machine_topo_get_cores_per_socket(ms);
> +}

I'd put those before/after machine_parse_smp_config
, just declarations.

And put definitions into hw/core/machine-smp.c again close to machine_parse_smp_config

> +
>  extern GlobalProperty hw_compat_8_0[];
>  extern const size_t hw_compat_8_0_len;
>  


