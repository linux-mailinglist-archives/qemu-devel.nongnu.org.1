Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C367AEE05
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 15:33:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql8At-0004wW-3z; Tue, 26 Sep 2023 09:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1ql8Ao-0004wM-Ih
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 09:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1ql8Am-0003ff-Lv
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 09:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695735139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XMRrcoMhGUD1HZXyU/fyculEL5ZdlVu4vnUlfFpRUn0=;
 b=eGQKulOrKXsovg2oQgwRLQ/71SzHfAK8Ffp0xzHIzpbbaQn7/xXWDSZlA6kR8NZka1/Om6
 6IenYtq6TS5bSEKBg/1wEJ+icjn1QGnUkBMgZ72DO0QwFVq6qS47weLjr+vxvwMJBOtHwx
 EETPb3e6Q/KOVojLTOtnxY66ZxgP+0g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-Pux8WqsoNq2dT-6q9dXGWg-1; Tue, 26 Sep 2023 09:32:17 -0400
X-MC-Unique: Pux8WqsoNq2dT-6q9dXGWg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9b274cc9636so440703866b.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 06:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695735136; x=1696339936;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XMRrcoMhGUD1HZXyU/fyculEL5ZdlVu4vnUlfFpRUn0=;
 b=rhdH0yr1okKsmI+oO7bDDUB/uYywSJAC/i6tiyHpOZUihKyoGq84EXFuAbUzk8+vts
 YoRoZI5s06j2ywTJ8K+p5aD8lEcPgxWp7mDcVst958cUVQ6FKw2vv4GAoHn8GJh79Y9M
 ZJvgBNdR+USHlLelkPtceYtN3Lwo/id1T/SjOMfXUxdcCcv/pQhGNv/R4HmRA2kU5kzH
 TJJrSC+b4ICdnQpil3+yrOkLYoVOQ/rs47GlDRrUQBOkHvIALu+Z18Fp4PbjPJgIjVEI
 wLJ0D/e2IYQCPMYSx8DRjfmANKHmzD9qD41GRYbK1ghWj+pymJbVSN89gAb/t8GkWx3D
 Cp1w==
X-Gm-Message-State: AOJu0YwO6hxyX/wFN99tfpVSQlm8WFe6pn49QIKHDF6b1z2qK3nARfZP
 VAHBEckepSdYCkke7B4fo5TILje+U5Bcy75uKVNmRPbZ+M0fjOXGl0pre96Z5wi/7UcGkYnLbGy
 08YwB5IAjw8njJ4M=
X-Received: by 2002:a17:906:208d:b0:9ae:3d8e:b635 with SMTP id
 13-20020a170906208d00b009ae3d8eb635mr8179626ejq.24.1695735136489; 
 Tue, 26 Sep 2023 06:32:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxURIqH8O3tSQ+/vEGed/g6eJrq4lxAX9Iu8awXMtf5/juvDKp6wfVwIzumjKAMcB/29BXRg==
X-Received: by 2002:a17:906:208d:b0:9ae:3d8e:b635 with SMTP id
 13-20020a170906208d00b009ae3d8eb635mr8179611ejq.24.1695735136132; 
 Tue, 26 Sep 2023 06:32:16 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 s4-20020a170906168400b009ad829ed144sm7765684ejd.130.2023.09.26.06.32.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 06:32:15 -0700 (PDT)
Message-ID: <fc005d50-03ba-0b8f-d9af-64a5297395a3@redhat.com>
Date: Tue, 26 Sep 2023 15:32:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Virtio-fs] [PATCH v3 0/5] vhost-user: Back-end state migration
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-fs@redhat.com, =?UTF-8?Q?Eugenio_P=c3=a9rez?=
 <eperezma@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20230915102531.55894-1-hreitz@redhat.com>
 <20230925204852.GG323580@fedora>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230925204852.GG323580@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25.09.23 22:48, Stefan Hajnoczi wrote:
> On Fri, Sep 15, 2023 at 12:25:25PM +0200, Hanna Czenczek wrote:
>> RFC:
>> https://lists.nongnu.org/archive/html/qemu-devel/2023-03/msg04263.html
>>
>> v1:
>> https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg01575.html
>>
>> v2:
>> https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg02604.html
>>
>> Hi,
>>
>> I’ve decided not to work on vhost-user SUSPEND/RESUME for now – it is
>> not technically required for virtio-fs migration, which is the actual
>> priority for me now.  While we do want to have SUSPEND/RESUME at some
>> point, the only practically existing reason for it is to be able to
>> implement vhost-level resetting in virtiofsd, but that is not related to
>> migration.
> QEMU sends VHOST_USER_SET_STATUS 0 in vhost_dev_stop(). Are you assuming
> that virtiofs back-ends do not reset the device upon receiving this
> message?

Absolutely.  vhost_dev_stop() is not in the migration-specific path, but 
is called whenever the vCPUs are stopped, which indeed happens to be 
part of migration, but is also used in other cases, like QMP stop.  We 
have identified that it is wrong that we reset the back-end just because 
the vCPUs are stopped (e.g. on migration), but it is what we do right 
now when the VM is paused (e.g. through QMP stop).

Therefore, stateful back-ends cannot implement reset lest stop/cont 
breaks the device.  I don’t think anybody really cares whether a 
vhost-user back-end actually resets its internal state (if there is any) 
when the guest driver asks for a reset on the virtio level, as long as 
the guest driver is then able to initialize the device afterwards.  I do 
think people care that stop/cont works, so it follows to me that no 
stateful back-end will reset its internal state when receiving a 
virtio/vhost reset.  If they do, stop/cont breaks, which is a 
user-visible bug that needs to be addressed – either properly by 
implementing SUSPEND/RESUME in both qemu and the affected back-ends, or 
by using a similar work-around to virtiofsd, which is to ignore reset 
commands.

It’s hard for me to imagine that people don’t care that stop/cont breaks 
some vhost-user back-end, but suddenly would start to care that 
migration doesn’t work – especially given that first of all someone will 
need to manually implement any migration support in that back-end even 
with this series, which means that really, the only back-end we are 
talking about here is our virtiofsd.  To this day I’m not even aware of 
any other back-end that has internal state.

Hanna


