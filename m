Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0908873A4CF
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 17:26:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCMC5-0003aG-D1; Thu, 22 Jun 2023 11:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qCMBm-0003P6-RR
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 11:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qCMBk-0001h3-7N
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 11:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687447534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0CSgMr8YKwuQ6xdtqio2ML7E9iZ0GLkqG4lEE5oQt5Y=;
 b=BstL2jGllC+OjlCaxRonKfXtENEJV11eyFlyvw9YNc0v+Zape+fzuZRioGujvdu4F/RtrO
 oA/lLYNqfOXAyeU1PQc3IdzfldPCF8Ex50cE8oW+3bFt3UpDLpL25VjAt0qlwsr6qbIq4h
 6xGDXavbsVX6JQzKJGUFUMSL0AQXjtM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-S6Y5KAGVMZSlKziHGZEdsg-1; Thu, 22 Jun 2023 11:25:27 -0400
X-MC-Unique: S6Y5KAGVMZSlKziHGZEdsg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-3f8283a3a7aso17650341cf.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 08:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687447521; x=1690039521;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0CSgMr8YKwuQ6xdtqio2ML7E9iZ0GLkqG4lEE5oQt5Y=;
 b=PCECMough6Mycadi3PPZvWTrzjsph8vLLAAHQ76RkHG7Nh/ehxTljex+69YJKjYNsP
 oWtzfirZfx18arPRxN6pslOCuE2HJfWePMyWAX69HG4mc9/O9tScql/6S+JuPCYYIKR9
 imYtx5PL0fCmzacBXRa1lN2wppz9KjGM/7t9IjBbUWFnat3ZOGjuhe8EAUcGBwuZCIfG
 wz1BUV9d+uynMdtm2UZieLUuyvkPMWFpCSWQng1Jecn0F48dMmxuOkelYsKkbjMsSv/X
 4a2q0jORv1OSLijX/m/ZXSZ9JyTQ3u7sPbHdb/Q0grgc5QLTUcM6oveN3KlX7oHatdeg
 zQkQ==
X-Gm-Message-State: AC+VfDy4jTL+99+DD/tDMHXV1tLYTYfeEubXHbtRzdaJa9gDz0j1CiY4
 ylVMJBQm+/O5/W4DCLpBfNdA2s6KhJ/isglmrWYZ9ZCmhrT382EuwnJvz9HO38UvXodtr1mgVgg
 H5NV8zGnCUaiZ9XE=
X-Received: by 2002:ac8:59c5:0:b0:3fd:e953:74ee with SMTP id
 f5-20020ac859c5000000b003fde95374eemr18837385qtf.2.1687447520889; 
 Thu, 22 Jun 2023 08:25:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ65eG9qHglddRW13TtmkIu5/EE0ckwLYjPA6UBz+MQgALd+w8V+qkzKFp5C8oahQj0zc8rSrg==
X-Received: by 2002:ac8:59c5:0:b0:3fd:e953:74ee with SMTP id
 f5-20020ac859c5000000b003fde95374eemr18837351qtf.2.1687447520612; 
 Thu, 22 Jun 2023 08:25:20 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 n4-20020a05622a11c400b003f6a607cf22sm3693286qtk.84.2023.06.22.08.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 08:25:20 -0700 (PDT)
Date: Thu, 22 Jun 2023 11:25:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: quintela@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Daniel =?utf-8?B?UC5CZXJyYW5nw6k=?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 libvir-list@redhat.com
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
Message-ID: <ZJRn3zMwA0DVkkcD@x1n>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com> <ZId0+HYF/ETLVri3@x1n>
 <875y7sflqb.fsf@secure.mitica>
 <d88c707a-abd9-6c8e-907c-13a3fa9a0219@redhat.com>
 <87wmzv7ubn.fsf@secure.mitica>
 <a81d48ac-4aee-1c5a-e530-20c634e42d5b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a81d48ac-4aee-1c5a-e530-20c634e42d5b@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 22, 2023 at 11:22:56AM +0200, Thomas Huth wrote:
> Then simply forbid "migrate_set_parameter multifd-channels ..." if the uri
> has been specified on the command line?

Yeah, actually already in a pull (even though the pr may need a new one..):

https://lore.kernel.org/r/20230622021320.66124-23-quintela@redhat.com

-- 
Peter Xu


