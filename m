Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A427CC5A2
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:11:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsknA-0003nV-OZ; Tue, 17 Oct 2023 10:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qskn6-0003m7-Eo
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qskn4-0002sn-UD
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697551882;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Pan8lzWANLXg6iraDnYODBgU2PJdAE3Z48rgZWNBpFE=;
 b=XecYa75N+ItH3o7qPGW75H6NQxcCq1Sg8xmy+78Z05aX0Dw+ftZ2jgzAMKAbhUvrzjc7Vx
 M5ctfb5kkuwToExyzvJ8teLbLyUgmzhba0vpQU39sUFGWAS034US9vb9zhGELm4ihk/od7
 j0lz/b51fKcfI1FRNMo/FjSE+ZlaSvo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-RL1gJzjCNhy6Smb1T17b3Q-1; Tue, 17 Oct 2023 10:11:21 -0400
X-MC-Unique: RL1gJzjCNhy6Smb1T17b3Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso39553515e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 07:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551880; x=1698156680;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pan8lzWANLXg6iraDnYODBgU2PJdAE3Z48rgZWNBpFE=;
 b=ileNiTEWz+qulfARxJpiybmdej1WxP5G84EflSS8QAlSVCkEb+liCd5hdhaMcBZO9Q
 J0qcIbpm09BoSmbGShroM6/ou5wGV9vE7Qfg26RRdcSSSLsN+Kza+YDbGXICjdpYc3g0
 +0Chc4IklmOM4Nbo38kvH2Rpcf6DjD7M1rdQl9g/DA/gKBo8kCAKAPr+OuWd3BHsA56i
 Q+58DtVt0c38Wlhzjumu8odmCeh6KfsYZCqWDKuHbGr5CMHSBl1bEZT6+dAs6kqrSaXa
 B09o8BMzzbRre0u2cXEGvAVv9MatXIYvZRpvg5fDPLBgbV4dXXRcJOQ0dnPH3XWD4Dyn
 VdwA==
X-Gm-Message-State: AOJu0YyTJqNeVnK8QBXnTRZKoI1XJx5o7BZK1sTZSCn8Ek5/iJgAWozx
 KlEMQdFxC9lGEXBOmUXMmXdZWDXrzD6hQzfMK/4M8BWmuAJOHubjNXt6e/Lwiwr3mZeOI9xq9Xv
 y2R057hrxlzHTryk=
X-Received: by 2002:a05:600c:4e92:b0:403:cab3:b763 with SMTP id
 f18-20020a05600c4e9200b00403cab3b763mr1645242wmq.33.1697551880040; 
 Tue, 17 Oct 2023 07:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrS61ABVkTlqmcLeub9e1WEW9cC1kZ1AxGa4sXlQp9adLhEE7QOd8JvpvVLbN839eR4QMqMQ==
X-Received: by 2002:a05:600c:4e92:b0:403:cab3:b763 with SMTP id
 f18-20020a05600c4e9200b00403cab3b763mr1645217wmq.33.1697551879592; 
 Tue, 17 Oct 2023 07:11:19 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c4fd300b004060f0a0fd5sm1654414wmq.13.2023.10.17.07.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 07:11:18 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,  Leonardo Bras <leobras@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Jiri Denemark <jdenemar@redhat.com>,  Avihai Horon
 <avihaih@nvidia.com>,  Fiona Ebner <f.ebner@proxmox.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 2/3] migration/docs: How to migrate when hosts have
 different features
In-Reply-To: <20230517062128-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Wed, 17 May 2023 06:23:26 -0400")
References: <20230515083201.55060-1-quintela@redhat.com>
 <20230515083201.55060-3-quintela@redhat.com>
 <20230517062128-mutt-send-email-mst@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 17 Oct 2023 16:11:18 +0200
Message-ID: <87wmvlz6d5.fsf@secure.mitica>
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

"Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, May 15, 2023 at 10:32:00AM +0200, Juan Quintela wrote:
>> Sometimes devices have different features depending of things outside
>> of qemu.  For instance the kernel.  Document how to handle that cases.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> yes, e.g. vhost features are exactly like this.

Yeap, I know that.  But not in enough detail to get a good example.

[...]

>> +In this section we have considered that we are using the same QEMU
>> +binary in both sides of the migration.  If we use different QEMU
>> +versions process, then we need to have into account all other
>> +differences and the examples become even more complicated.
>
> How do people know what to do?

They need to:
- know their hardware/device/driver.
- how they can do it in qemu.

I can help with the second, not with the 1st.

> How about a tool that will help you get data from hosts
> and then tell you how to configure qemu to make them
> compatible?

This is the holy gray of migration.  I would like to be able to create
machines from QMP.  That way, I can transport the configuration over the
migration channel, instead of hoping that it is the same.  Troubles so
far:

- we are very far away of being able to create machines with QMP (not
  migration related).

- we have properties that can be different on source and destination.
  For instance, the path to the file that implements a device can be
  different on both systems.

  We could add some keyword to the part of the configuration that can be
  different.  As said, we can say that destination/QMP can give us a new
  path for a block device.  But we need to be able to mark number of
  CPU's as required to be the same.

- For devices/state that can't be seen from inside qemu, I don't know
  have a good idea.  It can be related that I am not an expert on that
  type of devices.  Perhaps someone that knows more about they can give
  some insights.

Later, Juan.


