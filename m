Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC127A0AF0
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 18:41:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgpNb-00071s-IO; Thu, 14 Sep 2023 12:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgpNZ-000713-7o
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:39:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgpNX-0001B4-Vz
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694709583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XPC+iHsAVnDuMq42nWYl1smSDX6h2kMim/5bggfAyuI=;
 b=Ornwl8eak2YAiX7BVE0Qcz+6mNa5GFgL6/Ufs+Jh39mAMua2B7+2ZdY8ujrB0rkm8HfALl
 RqSXqCfKpWKr+oZICcS5DojUqP/x8HL5P1J3MtVJIMUcjb0DyLfjxb1S3DMWGvK4GI6KUV
 12i055GkC2iiSn+b7IXJMpTfx7cn71c=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-kH4QO7yiPUa8nljK9-JSwA-1; Thu, 14 Sep 2023 12:39:40 -0400
X-MC-Unique: kH4QO7yiPUa8nljK9-JSwA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7708c1ae500so21676085a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 09:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694709580; x=1695314380;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPC+iHsAVnDuMq42nWYl1smSDX6h2kMim/5bggfAyuI=;
 b=p6xgwqgIa60pfEncDuOWaEmijyFL5B6UJ8koXUuGCABrfoqg28Gr2W09lMQv9uz51W
 mWMqxPm5ORix9BFPLKYLPaPen8rrAaVFN311N2IyR5KHtUzVrtEZSgiFswEOnKIdiVZb
 nduuXtJ32313yCIFAFdFkH1LLhx3V+h7FJ7BqOKqB7PMnI9nBnB5CKkuBEDEReipvJcy
 AYDSMM8Y/VeBpTq/9HtbJfWWhXN/Ltxk66YQx/M9506TyW/xpjOm+aaJlgeYwEijxWkw
 PsHNRWlkepHVPdB+db46PuyF8VOlJ4mq/az7AnrLO5EY6tauD1wMkjS+9zQFSNMnURgI
 k1zA==
X-Gm-Message-State: AOJu0Yx/g8o42Sg+MlyLAzxKH4uEBI0pUDo7IgL5vfqxRNAvjX+3dXnJ
 4SszcfSuvKUQAzcHBKONhhytw8M/of4KrbdrMJQtMGkFX1UeZR61q+PamKfJBprEaDgZhkx4Bly
 X5GOmKM4C1kH8mYo=
X-Received: by 2002:a05:620a:46a4:b0:76f:b00:4e61 with SMTP id
 bq36-20020a05620a46a400b0076f0b004e61mr6325973qkb.1.1694709580221; 
 Thu, 14 Sep 2023 09:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBG/6Zb33UzxKXYiFNVOHC4e/xd4WP6xGOxjHzvqzRvEq8y6eFgWRXvzlWpT1ASQZ3cGHwkQ==
X-Received: by 2002:a05:620a:46a4:b0:76f:b00:4e61 with SMTP id
 bq36-20020a05620a46a400b0076f0b004e61mr6325960qkb.1.1694709579977; 
 Thu, 14 Sep 2023 09:39:39 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 dy6-20020a05620a60c600b0076ef40734c8sm586124qkb.79.2023.09.14.09.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:39:39 -0700 (PDT)
Date: Thu, 14 Sep 2023 12:39:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org
Subject: Re: QEMU migration-test CI intermittent failure
Message-ID: <ZQM3SV4eqSltoQSe@x1n>
References: <20230913192301.GA917052@fedora> <87r0n1kggo.fsf@suse.de>
 <ZQMfIO3oiqTsawtU@x1n> <87edj0kcz7.fsf@suse.de>
 <ZQMoUzRH1BZKs39g@x1n> <87bke4kasr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bke4kasr.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Sep 14, 2023 at 12:57:08PM -0300, Fabiano Rosas wrote:
> I managed to reproduce it. It's not the return path error. In hindsight
> that's obvious because that error happens in the 'recovery' test and this
> one in the 'plain' one. Sorry about the noise.

No worry.  It's good to finally identify that.

> 
> This one reproduced with just 4 iterations of preempt/plain. I'll
> investigate.

Great, thank you!

-- 
Peter Xu


