Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D10F7D6634
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:04:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvZmt-0006zl-Tv; Wed, 25 Oct 2023 05:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvZmQ-0006Zw-20
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:02:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvZmK-0005Dq-Dl
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698224533;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=IjR5wNdHMzC1bRbmm+lOJxOzfuKJ7as5U4Xsge4vXwQ=;
 b=GlF3JqnssGIVe8kqPk71ywEn7NvP4711Yx83t9N9mZnywojSKMbxOAx0/WlY/vUPxa3MP5
 VyJGN9GzG0mwExGPxiQJ+qTWBR0tQ199RTta55nEKSbhUYWfH63j1ewROgMN7C9wQQyOPp
 Sg0sRDjJZWI1ePcyY8cwONeQYVimE54=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-8PFKZuqPMuiceVpYVxFuBw-1; Wed, 25 Oct 2023 05:02:02 -0400
X-MC-Unique: 8PFKZuqPMuiceVpYVxFuBw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5079fe7cc7cso5642579e87.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 02:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698224519; x=1698829319;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IjR5wNdHMzC1bRbmm+lOJxOzfuKJ7as5U4Xsge4vXwQ=;
 b=ihLbLjUgYk+YAbifVSxLStHSsWtrRXQBzJo4TTG+bt1LDExx2cz416ff7+2K+m95Tj
 NHh5HCa/l00gGKbRPmA2Mw0i4233duSqzhkzTTdNJ+Kt7qcJXstS47MVnPZNQHpsVYb/
 tYhrkW8mG4PhMjgPZvP4gBho19T8+OEhBse/JO0uGI6eDY7xZcGyoS6k5cuqlRT5WY5r
 Z4Vxo1DiqmQm4cSWSRygIQjoJc/5b3NF7q2JIEpgDYpeHzYTLRefJHUEXYhCZeiUoNP8
 QbpXq/r2Zg9x093GV/Qyy/f35s47EY1DuriZajpyL+wqh2MVKz22/CWoMqLfGAR1XGjy
 yOSA==
X-Gm-Message-State: AOJu0YyC6CA0Ia0V44WGluo7wwG4C8yj4xt8BvK1+UxvCFdHQIwmfV5N
 yMo0bIFQeCMeoin49JOmHAQ2thar1TMaus9di8hgLfJDBtPpwMQMR+vsGeY/LUc/4J7YwOp3nvI
 rB+CMXRgDW4jugiQ=
X-Received: by 2002:ac2:54aa:0:b0:505:7360:6010 with SMTP id
 w10-20020ac254aa000000b0050573606010mr9738787lfk.28.1698224519665; 
 Wed, 25 Oct 2023 02:01:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlefXoVWEGYknS9bPbvlXd8JqYxNzSupLQ5Ou5EzeMSrK+CkZCiayYSfyEyA4v72PhyFgrXA==
X-Received: by 2002:ac2:54aa:0:b0:505:7360:6010 with SMTP id
 w10-20020ac254aa000000b0050573606010mr9738763lfk.28.1698224519198; 
 Wed, 25 Oct 2023 02:01:59 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 c16-20020a05600c0ad000b003fee567235bsm18729845wmr.1.2023.10.25.02.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 02:01:58 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org,  Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Peter Xu
 <peterx@redhat.com>,  Li Zhijian <lizhijian@fujitsu.com>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 02/12] qemu_file: Use a stat64 for qemu_file_transferred
In-Reply-To: <umpbv4qghflhubmfetanz6glvsgadn3yuybcarkyq6v2hd5awe@iylnmrsyqrv2>
 (Eric Blake's message of "Tue, 24 Oct 2023 13:14:01 -0500")
References: <20231024151042.90349-1-quintela@redhat.com>
 <20231024151042.90349-3-quintela@redhat.com>
 <umpbv4qghflhubmfetanz6glvsgadn3yuybcarkyq6v2hd5awe@iylnmrsyqrv2>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 25 Oct 2023 11:01:58 +0200
Message-ID: <878r7rf52x.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Eric Blake <eblake@redhat.com> wrote:
> On Tue, Oct 24, 2023 at 05:10:32PM +0200, Juan Quintela wrote:
>> This way we can read it from any thread.
>> I checked that it gives the same value than the current one.  We never
>
> s/than/as/

Done

>> use to qemu_files at the same time.
>
> s/to/two/

Done

Thanks.


