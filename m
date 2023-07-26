Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBED763FA9
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 21:32:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOia6-0003rv-AT; Wed, 26 Jul 2023 13:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOia3-0003rQ-II
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qOia2-0003k1-1S
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690393545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9GImxgUdYMZ49yLQ1z4eXiQK62MzicyE5+gftMX7p48=;
 b=HbGcORBII/uxIcdLWbLtSS2Qo+5i1Jzdx60E2lALYf0nelvT6DeSshw/YjwxoR8fuUtQ8B
 1ky7VUjJQ3UdyaMcPZ+c/u/ehJB+f9cM07jSEolZrJzZPKPpxRAGgwbeALFzqpzXZLNENw
 oBcjyfsY55TOdMxwOtnNRONOkIY7bJc=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-f73_EPSwPwmZ0ZKQWhdTFg-1; Wed, 26 Jul 2023 13:45:43 -0400
X-MC-Unique: f73_EPSwPwmZ0ZKQWhdTFg-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-79a06901112so2696241.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 10:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690393543; x=1690998343;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9GImxgUdYMZ49yLQ1z4eXiQK62MzicyE5+gftMX7p48=;
 b=AlYlapFdrPj6dS7t4s4U8y8ORQMX800u5S/iVMo/fqyOZVkxLED3iq/D567G0DSDmw
 Um0Xi7DVq1oRskxJ6/T32pO8eCzQiRlgKzdPFWwbCzRBHA8nEF4uqhq6j+XdVqxjQi1Q
 XHbTasGM4wUvVFl6Y0/58ZyTNXtFTJMYXJNUIoOtTMNrdRRqyaBeB022gaxLF8SEw5XE
 MxIHGByhBLBwUCbBnkNTrEfh9sUCCdunK/JM6ctAiM0bbqktBBSM2N7F5LCu/kElnuZu
 SGqoJG7K4RZj3DKWnIVfiJV9GsJqQ2USAXciFuO9KgjpT68aEP/8coimHSy1cecdiplb
 xr4A==
X-Gm-Message-State: ABy/qLZXreR2BkT5gp3FB3Ifml6t62NhTw8sBPXNR34HFGR/nKWBZyOj
 paPZ8ZXlS7GXl6ROD4muQ9TGfq78zlcxVtvCjEgv2X9JnxOSkEKs3K7OElYdWmJ3vbxGrsfiiJR
 LQ0HQJpbJ9hyUwSQ=
X-Received: by 2002:a05:6122:d91:b0:47e:9d33:6da1 with SMTP id
 bc17-20020a0561220d9100b0047e9d336da1mr1518548vkb.0.1690393543087; 
 Wed, 26 Jul 2023 10:45:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHsylbaqozANyJjSxPAIbUg83FrrMxmKoVnXwqqYjc00e6TFhh+WrPD1olph+hNhXD6xs93hg==
X-Received: by 2002:a05:6122:d91:b0:47e:9d33:6da1 with SMTP id
 bc17-20020a0561220d9100b0047e9d336da1mr1518536vkb.0.1690393542823; 
 Wed, 26 Jul 2023 10:45:42 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 z20-20020a0cf014000000b006362d4eeb6esm5188913qvk.144.2023.07.26.10.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 10:45:42 -0700 (PDT)
Date: Wed, 26 Jul 2023 13:45:40 -0400
From: Peter Xu <peterx@redhat.com>
To: hongmianquan <hongmianquan@bytedance.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, david@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] memory: avoid updating ioeventfds for some address_space
Message-ID: <ZMFbxFnv82AWlzLD@x1n>
References: <20230725112037.1762608-1-hongmianquan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230725112037.1762608-1-hongmianquan@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 25, 2023 at 07:20:37PM +0800, hongmianquan wrote:
> When updating ioeventfds, we need to iterate all address spaces,
> but some address spaces do not register eventfd_add|del call when
> memory_listener_register() and they do nothing when updating ioeventfds.
> So we can skip these AS in address_space_update_ioeventfds().
> 
> The overhead of memory_region_transaction_commit() can be significantly
> reduced. For example, a VM with 8 vhost net devices and each one has
> 64 vectors, can reduce the time spent on memory_region_transaction_commit by 20%.
> 
> Signed-off-by: hongmianquan <hongmianquan@bytedance.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Should be for 8.2, though.  Please always copy Paolo for memory related
patches.  I hope Paolo can see this.

-- 
Peter Xu


