Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA127DCFE9
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:12:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqO6-0004On-8y; Tue, 31 Oct 2023 11:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxqO4-0004Od-CD
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:10:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxqO2-00076s-Uf
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698765033;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GWgSEhq5pvFD5/ZtQFDqTczirvYVCrd6llOZCcowmM4=;
 b=V5PDttk8Zl4I3MiBcFM1eCZDPqz1ulsfa4yxr1nxJfEMqqkHjE0n659phABWydLQnpT4VR
 yaydQVAj0rdJe/XWT3bTasOBOvAAWobcg9qV9jKBvhdYSCuPNVYUkKn0IeGQYmzTQ8Y8Hv
 DfbgiN1ESnQka1JPtObhc97eJWd3hC4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-n5ySS8DPMC-DhiUuhnc7zg-1; Tue, 31 Oct 2023 11:10:32 -0400
X-MC-Unique: n5ySS8DPMC-DhiUuhnc7zg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32f68d3b788so2773170f8f.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698765031; x=1699369831;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GWgSEhq5pvFD5/ZtQFDqTczirvYVCrd6llOZCcowmM4=;
 b=p6AQ0U7yj8bMwk2szgny8fIlY8E6vWN4NcJQK5MfaAnhz9PhfhrVOcGofAWxmgGPKQ
 q/+0i/E8ET51hVP5eHMeEVlC0R2fAweeMivk2FTKiHcWi8tAOLUwLVZFpVJwZBe9KuKW
 Q62WkkTYM5JCF1sBS5SgBYUXBYhC4FpQtQg8UQDi4LLtjY+hpvaolzofNTV9shMXt2CP
 nzprPvM3Xgv0+c1kXqMru1lvifdg976ScjE++MuvCldLC4G3EDH7buHlpuAhwpkeSmd4
 MPpNCqTs76N5V6O7Pe7qwxS3l3PhRKRD+lElagBuMKgrQQz52VKCElxftDAE7ae8Jav3
 mPEA==
X-Gm-Message-State: AOJu0YwTyidzAR4JqH9bkZQJbJHbeQQoFZOmgpgELWH+PUuaYs+Zs9X4
 V8aOtGtnmAHjDjTCCGq6m0BxJNtHQaDWM6UcRFMBKXxx/51N9okfuulVyCl8003GSkO5DSdU/FX
 8Wfgm8XZlcbbqfmM=
X-Received: by 2002:a5d:5381:0:b0:32d:a430:beb with SMTP id
 d1-20020a5d5381000000b0032da4300bebmr8696001wrv.39.1698765031334; 
 Tue, 31 Oct 2023 08:10:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVu/1Fo2E4UyeUeoOMZ+ZMp5AignTumwBXBxCAVyXJgA7YVbhZCl/00P51xYu4g4NIkxS8Kg==
X-Received: by 2002:a5d:5381:0:b0:32d:a430:beb with SMTP id
 d1-20020a5d5381000000b0032da4300bebmr8695946wrv.39.1698765030985; 
 Tue, 31 Oct 2023 08:10:30 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 l28-20020a056000023c00b003253523d767sm1686834wrz.109.2023.10.31.08.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 08:10:30 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,
 prerna.saxena@nutanix.com,  dgilbert@redhat.com,  pbonzini@redhat.com,
 armbru@redhat.com,  eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com,  Het Gala <het.gala@nutanix.com>,  Peter
 Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v14 04/14] fixup! migration: convert migration 'uri'
 into 'MigrateAddress'
In-Reply-To: <ZTZfKJjG99L2i+Jg@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 23 Oct 2023 12:55:20 +0100")
References: <20231019192353.31500-1-farosas@suse.de>
 <20231019192353.31500-5-farosas@suse.de> <ZTZfKJjG99L2i+Jg@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 16:10:29 +0100
Message-ID: <87sf5q6d5m.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Thu, Oct 19, 2023 at 04:23:43PM -0300, Fabiano Rosas wrote:
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/file.c      | 2 +-
>>  migration/file.h      | 1 +
>>  migration/migration.c | 6 ++++++
>>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

I am assuming this reviewed-by applies to this and previous patches, as
I am squashing them, I can't do the "partial"e reviewed-by.

> assuming it'll be squashed into previous
>
>
> With regards,
> Daniel


