Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3297DF002
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:31:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUz0-0007xL-46; Thu, 02 Nov 2023 06:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyUyu-0007mX-W3
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:31:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyUyt-00078a-H1
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698921078;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZrDxUyHhiQDhbGr1BUJQlY8m1jW4wCYclCj/yCYXkgU=;
 b=IoOLFrTBEbjJ3ayp+Hws2ucidW2oZ8oiHRrFztHIYbPgjAjyri4bSejOLxjR+1o2RvL2J1
 2+uJyhAfy1Y5kgNQxbdZM+PUWRtCkYU5c680cydQedZGi9DY1e2YFU59kWlJKMJEPq/L+x
 nw4NT2+CkodYPDQJGmGmX3PCr0sbPZM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-cfxqD5xkPe-n5s7VrNMLzw-1; Thu, 02 Nov 2023 06:31:17 -0400
X-MC-Unique: cfxqD5xkPe-n5s7VrNMLzw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-407da05ee50so5141825e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 03:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698921076; x=1699525876;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZrDxUyHhiQDhbGr1BUJQlY8m1jW4wCYclCj/yCYXkgU=;
 b=fPMRtxHCTKMs+XedQ1/XkNdw5YBZl+d2W8qAt903dmIriq3z649/wq2NJlZRD4p2tm
 TOPZgim+VuSKXgmcJloAisT5XRkuymMJFyOL5LRcQvEEq01K0J3TdRs+ZnjdnlqMagAv
 kfA6Z+E8/s5JUgRJ5f9y3Jy3A6zNpaAOAMCkNkq6ilOf7MhxeKtbokyRNyPvINlbfjzF
 CI/bNR6Zp8kegGc9zK1uRPIvkzw2IrbTqdVs9/mX18G/CMdInoBgK+iI2049Y8WHU0qX
 t2A2x/97rdePkWqtMStDY6Cj2hdUNItiO+2UQcNeQwNvOaGB14cXDC4N4lVwbPaR+N9y
 RzOg==
X-Gm-Message-State: AOJu0YxD2rQ+7H7EbtgGV5VUE/s7aZdLPAVnlUfT/Uy6dwi0ZbdDuRf2
 tpDWaOf5qD+oaEHZ5++9M4bwOwhHLh822ulx8GELjlVxXh5JRRv3fwCAxBt1hmgXYw4x05GPBgT
 DDwiHZ+K/hC6rZXI=
X-Received: by 2002:a05:600c:46cf:b0:406:52f1:7e6f with SMTP id
 q15-20020a05600c46cf00b0040652f17e6fmr15937157wmo.12.1698921075937; 
 Thu, 02 Nov 2023 03:31:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEerTostmGfv9ORljrCTp9h4LzwZ2maXyZe+rPiRWmMUreaUWOkKrRHDK71youPj5ohDAxfVg==
X-Received: by 2002:a05:600c:46cf:b0:406:52f1:7e6f with SMTP id
 q15-20020a05600c46cf00b0040652f17e6fmr15937135wmo.12.1698921075535; 
 Thu, 02 Nov 2023 03:31:15 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 f8-20020a05600c4e8800b004068de50c64sm2429229wmq.46.2023.11.02.03.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 03:31:15 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [v3 3/6] tests: Add migration dirty-limit capability test
In-Reply-To: <e55a302df9da7dbc00ad825f47f57c1a756d303e.1698847223.git.yong.huang@smartx.com>
 (Hyman Huang's message of "Wed, 1 Nov 2023 22:04:06 +0800")
References: <cover.1698847223.git.yong.huang@smartx.com>
 <e55a302df9da7dbc00ad825f47f57c1a756d303e.1698847223.git.yong.huang@smartx.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 02 Nov 2023 11:31:14 +0100
Message-ID: <87pm0s30r1.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

Hyman Huang <yong.huang@smartx.com> wrote:
> Add migration dirty-limit capability test if kernel support
> dirty ring.
>
> Migration dirty-limit capability introduce dirty limit
> capability, two parameters: x-vcpu-dirty-limit-period and
> vcpu-dirty-limit are introduced to implement the live
> migration with dirty limit.
>
> The test case does the following things:
> 1. start src, dst vm and enable dirty-limit capability
> 2. start migrate and set cancel it to check if dirty limit
>    stop working.
> 3. restart dst vm
> 4. start migrate and enable dirty-limit capability
> 5. check if migration satisfy the convergence condition
>    during pre-switchover phase.
>
> Note that this test case involves many passes, so it runs
> in slow mode only.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> Acked-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Message-Id: <a05e931ed147696bd5924e0582db67a734547a3f.1697815117.git.yong.huang@smartx.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


