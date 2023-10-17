Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6FA7CC561
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:59:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qskbU-0007pm-I9; Tue, 17 Oct 2023 09:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qskbS-0007oS-71
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:59:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qskbQ-0007hw-Sj
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697551160;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=CQOCMYdYN44n9I+Cv50hddkJRbesVu+dM5oCsLLihn4=;
 b=A7E4mBpCdpCtjzT+ORusIiVUdD+r+1/f/qgC0DwfNBtgbadf3AwaRIn4VfafcUOOX3xexo
 p7q3xfXMFHu81X8zju3aYGo2QkdK1/gS+/YFoElHm6Esx721oL0sExjEgoL79Yehlp6usf
 HySRBlDq42OhtQLsCCjK5yeq5LCC5x4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-UIuhnDXXOfyjknfUQZfExg-1; Tue, 17 Oct 2023 09:59:18 -0400
X-MC-Unique: UIuhnDXXOfyjknfUQZfExg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4077e9112b4so17955585e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 06:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551157; x=1698155957;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQOCMYdYN44n9I+Cv50hddkJRbesVu+dM5oCsLLihn4=;
 b=PlQKyu1JF7wmYhUIjLDUQN8N4jb1QYLiFmmqrShfKmrcq/Vq6zuzkoSywIWUlxpumn
 QxYWI5mGMDGXldnwlqrMVFO8/dUsdydpwB5XdCLekM+qfWH4SRh8/WjOsRQZcr9c2h5N
 fOirCGizyRffl0QwLj0f9XPTFZ7y+MYizufCGnlk1O4tfjsx6zocj2YotSeQju1DubAn
 6ggMr15kjM4maB5cOHoEzfyA2xmXgjTqA1TbPu+OWFtXNoMUHceadHY5mg/YWI0+PtZO
 mzMEK0hQNcwZHxvOorKJo4mYqmX9I6WWYI8nR6SqfPLtond+Fwrh1ewDSoriMR2yfVfO
 YFbw==
X-Gm-Message-State: AOJu0YwayS/ZU9mvWbsfG0Ci9reFxby0TpHwvEcJ7Py/jdZ+xqFHjPd1
 KeQGtB1bE7NHA2phBT1ywnNpTrQFDucUofZXOfyQDe6p87hGMzmMF3YsZYewzvbp2DyswiZOix0
 aLtkV2K+XIIF9CBk=
X-Received: by 2002:a05:600c:468e:b0:405:3d04:5f52 with SMTP id
 p14-20020a05600c468e00b004053d045f52mr1778520wmo.24.1697551157538; 
 Tue, 17 Oct 2023 06:59:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXq5lYCJwilCn1wfgnoH2X8x7QlM2snZFSlD8q6oE6TbxMFw0NGDrOCNA28ytwzuQ2yyIMQg==
X-Received: by 2002:a05:600c:468e:b0:405:3d04:5f52 with SMTP id
 p14-20020a05600c468e00b004053d045f52mr1778494wmo.24.1697551157197; 
 Tue, 17 Oct 2023 06:59:17 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 l38-20020a05600c1d2600b004042dbb8925sm10036279wms.38.2023.10.17.06.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 06:59:16 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Peter Xu <peterx@redhat.com>,  qemu-devel@nongnu.org,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Jiri
 Denemark <jdenemar@redhat.com>,  Avihai Horon <avihaih@nvidia.com>,  Fiona
 Ebner <f.ebner@proxmox.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v3 1/3] migration: Add documentation for backwards
 compatiblity
In-Reply-To: <3b4731ca-c76c-cf11-d025-2c8397bc1c5c@intel.com> (Xiaoyao Li's
 message of "Thu, 18 May 2023 09:47:35 +0800")
References: <20230515083201.55060-1-quintela@redhat.com>
 <20230515083201.55060-2-quintela@redhat.com> <ZGQUMyKBbkLlsDhD@x1n>
 <3b4731ca-c76c-cf11-d025-2c8397bc1c5c@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 17 Oct 2023 15:59:16 +0200
Message-ID: <875y351haj.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> On 5/17/2023 7:39 AM, Peter Xu wrote:
>> On Mon, May 15, 2023 at 10:31:59AM +0200, Juan Quintela wrote:
>>> +Now we start with the more interesting cases.  Consider the case where
>>> +we have the same QEMU version in both sides (qemu-5.2) but we are using
>
> s/we are using/we are not
>
>>> +the latest machine type for that version (pc-5.2) but one of an older
>>> +QEMU version, in this case pc-5.1.

Thanks.


