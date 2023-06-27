Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC717400C9
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:22:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBRo-0006BZ-RU; Tue, 27 Jun 2023 12:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEBRk-00069J-Jv
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:21:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEBRi-0002Bq-NG
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687882897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X7Gvr9uhBafqrtgj/Y31cFUAKr0G36rCC4rmU/FFkKw=;
 b=ejMVhX7taeMQN6fp0GAkXLu1xBOas7157bu0y4g/uL7XVIHQkJmMrt/W478eoSQoQE7gWI
 lo/QdmgL5kUJblHd1w39TIA1jTvdGzkpJdCBDv5HqEt9nXquwEH9y9Wk7fGc/+e/Kxma6a
 ovhBVtCQuxZylvwWBx7KZTCjOKQwYI8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-w9mQIZ5CPMKvbh2xjCmAuw-1; Tue, 27 Jun 2023 12:21:36 -0400
X-MC-Unique: w9mQIZ5CPMKvbh2xjCmAuw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-765ad67e690so36680085a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882895; x=1690474895;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X7Gvr9uhBafqrtgj/Y31cFUAKr0G36rCC4rmU/FFkKw=;
 b=U6HUnYTLXrB7BQX5UoWokkqEVNJk036IvCHzYqPRfBbLC6KlXY928G384uj7gUIUfZ
 64WGzzObCSiLU5sAAUOJduKf5QDaPFn6xQObGE/rSjUmvrdOSXprK8RW9g6CNowMs29t
 u9BS/kN2zUtNnxXwusBreETVKdHjlP/ik1JwelGLVRwS/TDDUNYJ786DGvoRF7hoytKj
 N3dIkfdBLsjGzQG2OR4YUSP7jNk2XBOMmicneAvllfQKOeYOZoeTN+fiBgiF5y+6xrlJ
 ffBMvXmMYocaKtkxuQ6yu8HLnMqJllKtlSNVUSJ6vv+9ixOUaPcs3AgTEP6eJGfjExPC
 YtLQ==
X-Gm-Message-State: AC+VfDyGStlLo+CuVuvkCGLSLtKwWa7eUdx+biMg9x8DiWLLBCDaUsYA
 PafEERjs5L2BX5qeS6xIEM3ifZGwlZf8IcEwvt98xoCOZtkLnBsOId+qkHQSCKd2LO16pqxo3hm
 PQP22SHIXPu5AM6s=
X-Received: by 2002:a05:620a:1aaa:b0:765:537c:ebaa with SMTP id
 bl42-20020a05620a1aaa00b00765537cebaamr14185843qkb.4.1687882895722; 
 Tue, 27 Jun 2023 09:21:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6L7TjUbVlRxlfRcNTgMJpg3o13PYHsegkgfu/IIBluN8SDIckp8v+QMMWnJRk7J4XcTWHPzw==
X-Received: by 2002:a05:620a:1aaa:b0:765:537c:ebaa with SMTP id
 bl42-20020a05620a1aaa00b00765537cebaamr14185820qkb.4.1687882895446; 
 Tue, 27 Jun 2023 09:21:35 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 i2-20020a05620a150200b00759300a1ef9sm1402568qkk.31.2023.06.27.09.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:21:35 -0700 (PDT)
Date: Tue, 27 Jun 2023 12:21:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 5/5] migration: Deprecate old compression method
Message-ID: <ZJsMjVkZkTq+wqYq@x1n>
References: <20230622195019.4396-1-quintela@redhat.com>
 <20230622195019.4396-6-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230622195019.4396-6-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, Jun 22, 2023 at 09:50:19PM +0200, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


