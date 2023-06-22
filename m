Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D6473A7FD
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 20:12:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCOnD-0007o1-4D; Thu, 22 Jun 2023 14:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCOnB-0007kg-Cj
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 14:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCOn9-0002Nh-W3
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 14:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687457543;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sxmM1HUqxDGYzAup0ZlXsQhWCY7t0bgMK+rE2WTZoJY=;
 b=KAM/bvnkmV0drNHUD+FB069f7LkmSlkH6bqQm5OVwBUiZmF/bpMl15oFZ02Lhxgt9w0lkL
 fTr9PMgCtLLJT06cpWKhMNupTaeCIZJ6exnAlhVSGV4H2y2Oin3QM2d2C6CZHiNCi0yVUg
 5DNHjphmmE7Hqf2Q2XRAC0mR9TKGMjk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-5czFyZ4dOMGJX7QmXTBiPQ-1; Thu, 22 Jun 2023 14:12:21 -0400
X-MC-Unique: 5czFyZ4dOMGJX7QmXTBiPQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f863fcc56aso4349023e87.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 11:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687457540; x=1690049540;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sxmM1HUqxDGYzAup0ZlXsQhWCY7t0bgMK+rE2WTZoJY=;
 b=fNSs0MgR5gOHFeZeHqJAaaz1KmH4LDE9Dq9TzFeyyURBeK9mDQ/aLU/y1sB0v87oHb
 sD3r/3XASa+t941rZiAqsvEXgzLQ2eplYvTLzSgz0tnv9/QUHTDXjS8P3CDkI3qsFDB8
 UIfNLAzJN1FKs0HbzeRbYOzdGYmj2zQcWJA8XsHIe+sw4WN/h7bG4SY4N3Zmq73LVCQc
 jvJKzAYOg3YkJcrO/jrdHadoVJf9ugz6GHYbvx2kqI7Uj3FHfda0ctuEsZePxgbeyCGm
 fJQ+MAyiVXIwruxbUSQypenv7P7iF76vd32WMj5EOM4tLheEf05n6dRSTpBXyqc/Dl+G
 ypkA==
X-Gm-Message-State: AC+VfDzKbo1TJyh0mwvKWQF+W1Qjjstu8j9aAFsNKYNb0COApb8oBqz+
 O2lH/w4h7kmMSbqORJXIto0deAuea/4kuuKXScsoX1OAInY2rqMYIT0gpip9G6t3z/Z5Ryd81fV
 HCWrbREUshajTyoY=
X-Received: by 2002:a05:6512:b08:b0:4f8:5b23:5287 with SMTP id
 w8-20020a0565120b0800b004f85b235287mr6147832lfu.62.1687457540280; 
 Thu, 22 Jun 2023 11:12:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6uqwYn3thtfoEO8b2d+Iu43tNa8dCouwsu27rz3VI+lYHFuniAJ3T2jIZQ+UEL2RFrf56fMw==
X-Received: by 2002:a05:6512:b08:b0:4f8:5b23:5287 with SMTP id
 w8-20020a0565120b0800b004f85b235287mr6147812lfu.62.1687457540012; 
 Thu, 22 Jun 2023 11:12:20 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 f1-20020adfdb41000000b0030ae499da59sm7579329wrj.111.2023.06.22.11.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 11:12:19 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Leonardo
 Bras <leobras@redhat.com>,  qemu-block@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Fam Zheng <fam@euphon.net>,  Thomas Huth
 <thuth@redhat.com>,  libvir-list@redhat.com,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [RFC 3/6] migration: migrate 'blk' command option is deprecated.
In-Reply-To: <ZJGWLI9jl8MfJnd/@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 20 Jun 2023 13:06:04 +0100")
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-4-quintela@redhat.com>
 <ZJGWLI9jl8MfJnd/@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 22 Jun 2023 20:12:18 +0200
Message-ID: <871qi3fjst.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> On Mon, Jun 12, 2023 at 09:33:41PM +0200, Juan Quintela wrote:
>> Use 'migrate_set_capability block true' instead.
>>=20
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  docs/about/deprecated.rst |  7 +++++++
>>  qapi/migration.json       | 11 +++++++----
>>  migration/migration.c     |  5 +++++
>>  3 files changed, 19 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index c75a3a8f5a..47e98dc95e 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -440,3 +440,10 @@ The new way to modify migration is using migration =
parameters.
>>  ``inc`` functionality can be acchieved using
>>  ``migrate_set_parameter block-incremental true``.
>>=20=20
>> +``blk`` migrate command option (since 8.1)
>> +''''''''''''''''''''''''''''''''''''''''''
>> +
>> +The new way to modify migration is using migration parameters.
>> +``blk`` functionality can be acchieved using
>> +``migrate_set_parameter block-incremental true``.
>
> Same comments on rewording as the previous patch, so won't repeate them
> all.

Did the same than the previous one.  Thanks.


