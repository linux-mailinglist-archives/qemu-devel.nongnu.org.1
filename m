Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C2D74A3E6
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 20:50:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHU34-0004Wp-65; Thu, 06 Jul 2023 14:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHU32-0004WK-Iu
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHU31-0004Oa-1V
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688669383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D3yL3qsWg+DO3jkgC9JFdTKiCBmHm6gB4MslFgWsF4U=;
 b=I9HidkJTfLkgKQD93xartWHK5IOHwqDkQXgkjkfRjANUDx+LmxtF3nxOcvzB/aBSn1pODA
 ajBtN3DLuGE5QBfFsj+Z5Cf+GLPmpS+NWsqIGDZ1dEnwStJPUMr+oK0EFTBLc4MLUIMAas
 eLpYUaBhkVuewM3BsdRhv1MAwzr6jWM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-zkcPCUclNrmfBExHvsa3lA-1; Thu, 06 Jul 2023 14:49:41 -0400
X-MC-Unique: zkcPCUclNrmfBExHvsa3lA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7672918d8a4so27795585a.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 11:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688669381; x=1691261381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3yL3qsWg+DO3jkgC9JFdTKiCBmHm6gB4MslFgWsF4U=;
 b=WCr6RYkCjbTCq5mSA2gsiphuXG5UW5YUgsB4aDmqeXg75E+CI2L8NHwAiFrOT9PU6m
 PUupn17k/G01Vs7pPw1R9VoIErXRQv12MzzjOS48yx5NShSGGOark8cWGXEAZMdC5K+0
 lw1FEsPYCLvaqQXvGMqwz79XHapqkI2egN4HAMwZe7v5AoeM56juMgOxzt/d+jCgeUoj
 yl9iC3+HVnEZFX71BjU1p9KQytBd16Ywd0dVwC3sxUT19jhYR6aKOgM36jCeqyyjHj4k
 92zXY3yL0mg1LBvbQG5n4+ri7HZ+W9hgBdTk6ci9tnEZbaNRjDKCM9FMQcnsKZQmeEQH
 3dNA==
X-Gm-Message-State: ABy/qLZ4d/dhDuhFkpqQJjWM50Iqzw+GwD/Z3fwt4yxvKjYfI+BIw+D1
 ixdGrIT7agS0z264N5OXlGCbNBz6U8gN6JVG0TDdAj3USgs391Wmc2WcsotAM0ozKLXr2VFIiMV
 R22OX8J2Y6ZRV+NA=
X-Received: by 2002:a05:622a:1a04:b0:402:ae02:a713 with SMTP id
 f4-20020a05622a1a0400b00402ae02a713mr3308112qtb.3.1688669381476; 
 Thu, 06 Jul 2023 11:49:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFQsYL9jxYge9k7Pme1KnlPF1cjdn3SRQvehkBMSyj/C6ze4jhWrqX4wEsg1e9n/4RnV4ms3Q==
X-Received: by 2002:a05:622a:1a04:b0:402:ae02:a713 with SMTP id
 f4-20020a05622a1a0400b00402ae02a713mr3308099qtb.3.1688669381197; 
 Thu, 06 Jul 2023 11:49:41 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 m5-20020aed27c5000000b0040331a24f16sm919865qtg.3.2023.07.06.11.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 11:49:40 -0700 (PDT)
Date: Thu, 6 Jul 2023 14:49:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 6/6] tests/qtest: migration-test: Add tests for
 file-based migration
Message-ID: <ZKcMuMJU6y6UWlFY@x1n>
References: <20230630212902.19925-1-farosas@suse.de>
 <20230630212902.19925-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230630212902.19925-7-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Jun 30, 2023 at 06:29:02PM -0300, Fabiano Rosas wrote:
> Add basic tests for file-based migration.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

One trivial comment below:

> +static void test_precopy_file_offset_bad(void)
> +{
> +    /* using a value not supported by qemu_strtosz() */
> +    g_autofree char *uri = g_strdup_printf("file:%s/migfile,offset=0x20M",

Better reuse FILE_TEST_FILENAME.

> +                                           tmpfs);
> +    MigrateCommon args = {
> +        .connect_uri = uri,
> +        .listen_uri = "defer",
> +        .result = MIG_TEST_QMP_ERROR,
> +    };
> +
> +    test_precopy_common(&args);
> +}

-- 
Peter Xu


