Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBED74A3E7
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 20:50:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHU3E-0004ZO-Bn; Thu, 06 Jul 2023 14:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHU38-0004Xi-Pd
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:49:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHU37-0004Qr-CQ
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688669392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GAluHrqXf6pyaW3w7RgSxDMKgUubP62GRiXg5o/8n2o=;
 b=eyAduDIhe1v4Zceub9rPcG8urwVzmH3ygD/aeEEQYfoYBUEFDKDeV400IM6JCiBkQeh8jf
 cHLAPnaCZ4f6gcb7TtIPpp5mpbAnwWrDli29sszqk+y9JVQ3viU6Pz7Jme1dBE7PDctxW7
 FuX+AEFuE6hX+F5UAz+MXs0FB27Lhqw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-5aIc64NvMJ-vIj1EI-J7MA-1; Thu, 06 Jul 2023 14:49:51 -0400
X-MC-Unique: 5aIc64NvMJ-vIj1EI-J7MA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-401df9d2dc4so3079621cf.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 11:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688669390; x=1691261390;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAluHrqXf6pyaW3w7RgSxDMKgUubP62GRiXg5o/8n2o=;
 b=LFsffLI5erAE1BCY8xkAhpvwBxBdVVMA6xH5ZofVTnEBAAb7GQInP2HxqDaMdJiDpJ
 Q37oh9mdIPPFlw+46tLxWXlpUfqgPqExJ6qMBEFHjqHjTxewA7q9FszwMl9R6okvvy9e
 ghvo4jL2XVdZTo1zvUSV/aEGtYcQSYN/LRke8+ZksBIDivleHKzVBYU+FOwHBSPmG7Ii
 ZGBe1/rVQo3WXCZDkiGSgcANAqvypJphPxN3oVdW79bIsM5KoU+4qiaem40CWWME3RGX
 A2jneXIAlp1v3+hN3GHRjlmxZE6S2f30x/Hj9SLl3OurQbvj8kJ9WsZe+MgZgVbe/tEO
 zMUA==
X-Gm-Message-State: ABy/qLZ8XeWdAlmQkvQLGRaWQG+kPmBRTXHFbw7+l659lhlk1GZPKM00
 iKZo1DNp/Fap0S24qlov0SwgbFkrI48FYtibBloZ2gaJjMKpfbfKvJocxNj+pPMalJmtHj68SC5
 3OA2MMkZe7vCj2ro=
X-Received: by 2002:a05:622a:1a2a:b0:3ff:3151:a8a7 with SMTP id
 f42-20020a05622a1a2a00b003ff3151a8a7mr3336555qtb.3.1688669390717; 
 Thu, 06 Jul 2023 11:49:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlECFKD0mCXQSZRImLpCIhEvt3plYOc0pepXwb5RaFIYDWV8Y6JiDW0FLw6qpMsZuC8g59HhfA==
X-Received: by 2002:a05:622a:1a2a:b0:3ff:3151:a8a7 with SMTP id
 f42-20020a05622a1a2a00b003ff3151a8a7mr3336551qtb.3.1688669390498; 
 Thu, 06 Jul 2023 11:49:50 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c13-20020ac8110d000000b004036ec58b11sm873418qtj.84.2023.07.06.11.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 11:49:50 -0700 (PDT)
Date: Thu, 6 Jul 2023 14:49:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 5/6] tests/qtest: migration: Add support for negative
 testing of qmp_migrate
Message-ID: <ZKcMzL5X+9Dry37g@x1n>
References: <20230630212902.19925-1-farosas@suse.de>
 <20230630212902.19925-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230630212902.19925-6-farosas@suse.de>
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

On Fri, Jun 30, 2023 at 06:29:01PM -0300, Fabiano Rosas wrote:
> There is currently no way to write a test for errors that happened in
> qmp_migrate before the migration has started.
> 
> Add a version of qmp_migrate that ensures an error happens. To make
> use of it a test needs to set MigrateCommon.result as
> MIG_TEST_QMP_ERROR.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


