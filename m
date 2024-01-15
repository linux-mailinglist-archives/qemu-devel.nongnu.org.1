Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6860C82D6A0
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:02:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPJmd-0002GM-Dz; Mon, 15 Jan 2024 05:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPJmV-0002F8-5O
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:01:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPJmT-000578-KA
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705312880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X4XvVOqAoAl7y5IM/MrQeM7Q3zfFN6yXEQZy7fVOQno=;
 b=gw0OavJLA1lbFbclsX8rt9Pm4qcCPJXxWeTV5QOHY71S33fSPzeREU/rtqVOPjYO2jDUoR
 HRfYxVc1PHUYvoCRkHDPsQ+LKWLc1y7tibrZfwtT1pohdsoIG/YnbkCNWJdVW1lK6weVQP
 aLCi8lzUETmNGIjDa+BnltH1QBsUAtc=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-fM7OwgJoN3e5fEoLxkFT7A-1; Mon, 15 Jan 2024 05:01:16 -0500
X-MC-Unique: fM7OwgJoN3e5fEoLxkFT7A-1
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-35ff7c81ed9so10795585ab.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 02:01:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705312875; x=1705917675;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X4XvVOqAoAl7y5IM/MrQeM7Q3zfFN6yXEQZy7fVOQno=;
 b=wY2ki091ZnRHVhAoDDB4/FOqSmf3tdqWEUJSwgcW9sZg8wGn9bGiHiz5GXZI+UgwlD
 lXPMgvBiJYevGlE+f4xHu71BVR+B5OkFVjC/P6DfFaBrcuKgqWftYRqXBg4O4naFpojO
 W4cQxxW2JO5+aSKhlzAG09gmumfuha/qqGgljMuAlp2a5VF2mszmMuDv9j7YtTbfCAnQ
 hsYMoZD5+NPUm0CKBU+PnekvddkAbCOfTpA441j4pm0yYm3sbgRmDYRo4edfqMC8ObKU
 Ot5scD7ebd2vQREMPwx+XCYdC59MM5kbyCneG9Sq1QuJo1cKkDTMT6EvaJPxKvVy6PeY
 fsfg==
X-Gm-Message-State: AOJu0YybxWB9Ous0JNGCr6yr/zpqNb6LoFJNKkXiHKe3qgu8RCJn6KLG
 6l4sdJNBVy9ORw01pyS4TkeQd3oZjZ9vKaPtiVb9j9ope2L4/fECbctkIMwLQgmaaqO4TVQcTBu
 /4+/84GiIhFxXZ8rVOMistUY=
X-Received: by 2002:a6b:7e42:0:b0:7bf:4789:9e05 with SMTP id
 k2-20020a6b7e42000000b007bf47899e05mr1600689ioq.1.1705312875717; 
 Mon, 15 Jan 2024 02:01:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjdvUPRiATOLi55K/zsQvSFd/1JJwbALkE3TLvmRK8qEt+PWkzSCNzFzran1TSzexw4OMf2g==
X-Received: by 2002:a6b:7e42:0:b0:7bf:4789:9e05 with SMTP id
 k2-20020a6b7e42000000b007bf47899e05mr1600670ioq.1.1705312875451; 
 Mon, 15 Jan 2024 02:01:15 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 n35-20020a635923000000b0050f85ef50d1sm7681445pgb.26.2024.01.15.02.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 02:01:15 -0800 (PST)
Date: Mon, 15 Jan 2024 18:01:03 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Nikolay Borisov <nborisov@suse.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 10/30] tests/qtest: migration-test: Add tests for
 fixed-ram file-based migration
Message-ID: <ZaUCX3AVqoBz4Iv_@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-11-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127202612.23012-11-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Mon, Nov 27, 2023 at 05:25:52PM -0300, Fabiano Rosas wrote:
> From: Nikolay Borisov <nborisov@suse.com>
> 
> Add basic tests for 'fixed-ram' migration.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


