Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D377CE749
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 21:03:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtBnf-0006ZB-ND; Wed, 18 Oct 2023 15:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtBnM-0006Uc-FU
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtBnK-0000m0-SG
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697655685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FQyPnzbyIc8+8bcU9PxA+yscZOkI56e6lhL8g+3/YN8=;
 b=BxKeWtDzyrzFOyHvO1h1j9FPQ76xWj0TsQVkrIsAKxGxlSd3MgqVB6+dzOoE2yTFQN0+3n
 owAm40HV9T4jyYEXaY06kMkeVliZcCugZe+yY1v298fM5g6ZNf+zL81cV+LkldbCONz880
 SR1845y++LccqIOkHEgT9Sjb4QPAdZU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-MXGroT4tODCHTlB_0kbfOQ-1; Wed, 18 Oct 2023 15:01:23 -0400
X-MC-Unique: MXGroT4tODCHTlB_0kbfOQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-775842dc945so127206985a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 12:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697655683; x=1698260483;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQyPnzbyIc8+8bcU9PxA+yscZOkI56e6lhL8g+3/YN8=;
 b=oUs6rySmx5fvE6jVxLARz88NvowUuMlvRpVMbcDpgMDT3g94YhuCUq+DEIKgcjQWAF
 zvvw+OpK/cfkJuyzC2iBfgUxjmJ8K+pb+GUKHiOClN1WwyvZ3wvpuzd+YtSncQwXCE+a
 5J3dBUnL4AQXJubgh6pPFptHNZtIQNyH7iKyw7tNinc4z9R6bx57LcxCwIqRPjRjUM6B
 kPBkCsugdOus9oj8+3jcqhG0EUFr6PFwwWWeipU08X30tvy/IG7tRR+JiKoBunHlucZG
 ZrBRVqCXaMrbeO0CQPnqM/5WD7jnW6mae8NbZhkiGi41Rlrn7jLqI2oVpYNvaAKXeE/6
 rcKw==
X-Gm-Message-State: AOJu0Yw46E4qHK7zjj/4PIjFj/m/pJBDvTUgjZbZvDWY7c5agAP2yLTo
 4hdZgJ255jPn4pFGboJELNSC0iMYbYx9LyT52a0sfO5HrdLnXXD/xr9eK2AHQTFDQhq4Ygy9d3H
 w/bF/+Bx3JzjOnYY=
X-Received: by 2002:a05:620a:1a87:b0:778:96e8:90af with SMTP id
 bl7-20020a05620a1a8700b0077896e890afmr46092qkb.5.1697655683300; 
 Wed, 18 Oct 2023 12:01:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTo+uA/gKA8eguf4iSaw3N7ioi4UiLWa1rf3AdTQ2/y6eY/1OBqH/YZFWuzabg44dawv2J1A==
X-Received: by 2002:a05:620a:1a87:b0:778:96e8:90af with SMTP id
 bl7-20020a05620a1a8700b0077896e890afmr46075qkb.5.1697655682968; 
 Wed, 18 Oct 2023 12:01:22 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 e25-20020a05620a12d900b0077412ca0ae1sm169912qkl.65.2023.10.18.12.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 12:01:22 -0700 (PDT)
Date: Wed, 18 Oct 2023 15:01:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 00/11] tests/migration-test: Allow testing older
 machine types
Message-ID: <ZTAretx8ppmUXkod@x1n>
References: <20231018140736.3618-1-farosas@suse.de>
 <87jzrkdne2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzrkdne2.fsf@suse.de>
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

On Wed, Oct 18, 2023 at 11:19:01AM -0300, Fabiano Rosas wrote:
> Let me point out two situations that came up while developing this:
> 
> 1) There was a generic command line change in QEMU (-audio option)
>    introduced this cycle that was ported to the command line used by
>    libqtest.c. This means that when using the same command line to
>    start both guests, the older one will not recognize the option and
>    will break.
> 
>    Ideally, we would keep command lines out of the library and require
>    each test to provide their own. Then maybe the migration code could
>    cope with the change somehow.

Yeah this is unfortunate, and I hit it as soon as trying this out with an
old binary.

One other thing on top of this: the cross binary tests for different
devices, where we used to hit issues when some specific pci device or a
pcie root port failed to be compatible with old binaries, iirc.

I'm still not sure what's the best way to do that, though, especially if
the migration failure can only trigger when a device driver setup the
device first.  Maybe we can start with migrating a device with the reset
status between binaries.  Having this series is definitely better than
nothing already.

Thanks,

-- 
Peter Xu


