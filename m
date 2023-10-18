Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 515907CE716
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 20:44:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtBWW-0001xQ-6V; Wed, 18 Oct 2023 14:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtBWU-0001xD-Kc
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 14:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtBWT-0005uC-84
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 14:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697654640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nzv3pFD5f3Y0KSCyOV0yRvL5MdhYRV5PQ5VGwHuyeRM=;
 b=UoDh4avsjtaqcCmPCbC2/8zIbJsOwx7Q67dg0i45t1lnFR95jdeerRHsvs9yrflqnUBhBm
 r7mGos7oQEmZxBojmGtXZawm6doi6SYOkFzp0NGm6Z0yZY+GQCsoXUNbtnzkzsOev/SULg
 x+KLj3zncSGiXUKAkbaTAh//FDEurGU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-cRkYf6yMM8eVlV7J8bLSpg-1; Wed, 18 Oct 2023 14:43:48 -0400
X-MC-Unique: cRkYf6yMM8eVlV7J8bLSpg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66d7b75c854so1826196d6.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 11:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697654628; x=1698259428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nzv3pFD5f3Y0KSCyOV0yRvL5MdhYRV5PQ5VGwHuyeRM=;
 b=DJ5dHEse+Z1FhF2PKXgDZdwUwtcn/ma22Xpg8dJxNG9iXajHGOhz8muEdHUeAvhUCG
 Yxyhubu5EywZYfqqbAQSDNFm10+CzBC/cevCrtzRp6HdD9Ai2oURrfMFvkpstwLxfN2t
 c9av0G1wafRsHeML3evIQrFrcKAvQJ9pvuR5H0bmo7MZLK41neSBfIYP0BO59z+z3FKi
 e87TEvOP+TsRD+baZCgjaUxjBesdgBrbmYS/WBTlwbylaWGvE3yZUwpJnrD9MpiLE5nS
 sUbPAo27RuBnaWyCAsksHam/kC0FQHi4Nb4Onqec9ZuK7Mj+244t9kCd34cgA3WeWUhR
 uJXQ==
X-Gm-Message-State: AOJu0YxMevZXirOAJZNAVd5FZf0NubX6k2R2UKHqkaeUBm42Zgm8GTBj
 95V2B5gY6hKBoUmRiSkxYdZ8S9zos5kMR67RhjaonFrGWvsZLLIkOWHF2BV8Teetx+Rd8uVY2wz
 DdDJ1g+YG2312cIU=
X-Received: by 2002:a05:6214:11a3:b0:66d:169a:a661 with SMTP id
 u3-20020a05621411a300b0066d169aa661mr93491qvv.4.1697654628456; 
 Wed, 18 Oct 2023 11:43:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUHRUhPwYm6/1bR8/oarcJItBNyCWc0edO8tRMHPeJ76cemEDQVjd/9griKOO52HAoH/H1iA==
X-Received: by 2002:a05:6214:11a3:b0:66d:169a:a661 with SMTP id
 u3-20020a05621411a300b0066d169aa661mr93477qvv.4.1697654628142; 
 Wed, 18 Oct 2023 11:43:48 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 ec15-20020ad44e6f000000b0065cfb75fe81sm156112qvb.67.2023.10.18.11.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 11:43:47 -0700 (PDT)
Date: Wed, 18 Oct 2023 14:43:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 10/11] tests/qtest/migration: Support more than one
 QEMU binary
Message-ID: <ZTAnYf6Q7m2CHBFv@x1n>
References: <20231018140736.3618-1-farosas@suse.de>
 <20231018140736.3618-11-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231018140736.3618-11-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, Oct 18, 2023 at 11:07:35AM -0300, Fabiano Rosas wrote:
> Usage:
> QTEST_QEMU_BINARY_SRC=../build-8.2.0/qemu-system-x86_64 \
> QTEST_QEMU_BINARY_DST=../build-8.1.0/qemu-system-x86_64 \
> ./tests/qtest/migration-test

Please also touch up this example when repost; I think it's not allowed
now..

-- 
Peter Xu


