Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECC8749741
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:17:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKAc-0001xe-Gg; Thu, 06 Jul 2023 04:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHKAU-0001rS-UV
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHKAT-0007al-4R
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688631408;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=rBAJBMurj6/LndMIg4U/2RpUQS73HH8z/0eX/Kl/S6Y=;
 b=ESuhrQSv+O4xDXH/e8R+ZpBsc4ThARbcYnYTaDh7DQ3pvq2QavBQyOQgvvy1d/peuIPrgp
 wkcnkr0jIds01+63ww57KQyOoRKm/BNah1QFlHbPqWn3fJaFu1h99bnRQogdoiAbJRBKCO
 An7R62EmSms1brSi5MReIusChqP8bmw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-KDzIW8mZP8OlOEo5_NYBlw-1; Thu, 06 Jul 2023 04:16:46 -0400
X-MC-Unique: KDzIW8mZP8OlOEo5_NYBlw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fa8f8fb7b3so3738235e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688631406; x=1691223406;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rBAJBMurj6/LndMIg4U/2RpUQS73HH8z/0eX/Kl/S6Y=;
 b=EPOpd1okUOxOqk+otS7oIq+9HGLmTwObIHWa6Th9k3RQk41rG2b7+bZTTUTQblcBtC
 YwHEL7nZ7rs12wZO2hsoxBxRu3iQ/NO5IVtQvUZZz8CmLpwGLk4kQapsa09DBlTYfd+5
 rb9PvaoMGxXyN0mUcbi0F/YAvGlwgO0xfUfMdo3gOhpjcrQ9tMyGLPXndQ9bO9gcxiDk
 2AnuAiTU8ryCQ1rkj9QNdm475Y7vYY1II97i2ojixfIDEASxJ7+iuYMHGT+vNANaQcn7
 aV29tc59F+e5DdJbR8ejxi5r4RloM+1vVI+pwZyXONdZi89Jg/JvYnzDXI8P9WSqT4Sy
 1qzQ==
X-Gm-Message-State: ABy/qLb3ePOlSIFJvwde2oMTFWy7JZ4SI6+lPutIVCoQ5vfIER9BWYmL
 4iSHbxBYCh4FDcDj2iDmb4N8jDdKm/s4ilNdnOike7l4oWs+TxgFkER7M2q5kqm4nGTYu1ss7FL
 C0zWb3U0jk383ae0=
X-Received: by 2002:a05:600c:2187:b0:3fb:bc6d:41f7 with SMTP id
 e7-20020a05600c218700b003fbbc6d41f7mr1480403wme.27.1688631405762; 
 Thu, 06 Jul 2023 01:16:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFaoltnkyztjY2ma+4ASQhN97VimsDJKAdtE+DiEWDX9c/MNpeMR3dHJwJxQdnFdaEjkeMZ0g==
X-Received: by 2002:a05:600c:2187:b0:3fb:bc6d:41f7 with SMTP id
 e7-20020a05600c218700b003fbbc6d41f7mr1480379wme.27.1688631405422; 
 Thu, 06 Jul 2023 01:16:45 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 c14-20020a7bc84e000000b003fa74bff02asm1338142wml.26.2023.07.06.01.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 01:16:45 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peng
 Tao <tao.peng@linux.alibaba.com>,  Mario Casquero <mcasquer@redhat.com>
Subject: Re: [PATCH v2 3/4] migration/ram: Expose ramblock_is_ignored() as
 migrate_ram_is_ignored()
In-Reply-To: <20230706075612.67404-4-david@redhat.com> (David Hildenbrand's
 message of "Thu, 6 Jul 2023 09:56:08 +0200")
References: <20230706075612.67404-1-david@redhat.com>
 <20230706075612.67404-4-david@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 06 Jul 2023 10:16:44 +0200
Message-ID: <87bkgpbgk3.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

David Hildenbrand <david@redhat.com> wrote:
> virtio-mem wants to know whether it should not mess with the RAMBlock
> content (e.g., discard RAM, preallocate memory) on incoming migration.
>
> So let's expose that function as migrate_ram_is_ignored() in
> migration/misc.h

Reviewed-by: Juan Quintela <quintela@redhat.com>


