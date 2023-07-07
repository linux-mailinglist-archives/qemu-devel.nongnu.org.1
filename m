Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC8B74AEC9
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 12:36:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHioy-0001al-RS; Fri, 07 Jul 2023 06:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qHios-0001aI-Ey
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:36:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qHioo-0005Dj-E8
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688726165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=77Uf3vHUJAUtylrUh6utMWDwWeM8+WpotWwHGq9xzO4=;
 b=RMsLSM2eMGGrCwMtb1HA/9ma6yJBRCeaNea2Y/hARUfoyJ2XJkU3k5/K0iu792t0NrI2ZD
 xc1f8H7qucX1JeCPYUfZVbWTFrOHTQjqvTaVskjDOJrGAxSwouiojWPszgVbxhE9pIzW6L
 W4n3KXarPcqRotlKx27kDu3su25m3AE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-hqy3s5dlNKWRT91lgAS5dw-1; Fri, 07 Jul 2023 06:36:03 -0400
X-MC-Unique: hqy3s5dlNKWRT91lgAS5dw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-766fd51ee68so188480885a.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 03:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688726163; x=1691318163;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=77Uf3vHUJAUtylrUh6utMWDwWeM8+WpotWwHGq9xzO4=;
 b=Kc1wnWT0xGKWMslbTrgHQ2Wf1/3JKx5JPi99dZEBLA6L+XIe8VvPQ0xaqpCU6qjEQ5
 7RMMuuDO77Wb1Emo/i93SdVj6CC1Wl+0ewqtXxyEunk+Lgwn1jnov1qklQ0GmbVGVFHu
 xePoyZxIQdE2xTrmsnAtlJtyY93suN/3OHv8dRAwHVmEEP+OhYP64PG9iRWZyhZHsUrX
 7ddOouSXAoDBxfI07hWp5YnNCkg6+7L/ldGDz+4x5ojdHGvvsBooyb8mWjgEGe3AF780
 iqRskHkQAKyErW5Oerzya6qhPXgtjCShYuW+uHtKuYBT27mCTdYMIkQ2ipZMrQ1TK8v2
 U9Mw==
X-Gm-Message-State: ABy/qLY3lD0z3zJMCiHsrp1tvwsYjD6IslgvaGd64sQdFRVv/zjSNDYM
 I8VoGb7gyo0B9B+f6HaTqHdX851s4cjqlRQJ7YcoO/KtQYYIvPHJOh+V/4qBiNv1LUPAGVwp7lh
 6oVG93Mu7S7nx4Go=
X-Received: by 2002:a05:620a:2949:b0:767:18f8:7b20 with SMTP id
 n9-20020a05620a294900b0076718f87b20mr9308123qkp.19.1688726163445; 
 Fri, 07 Jul 2023 03:36:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGIXyiqWjBdGdKFZwobESisxGkC5/+1q++28fKnfYLxaBHQde7VcYUssDCOcXuMkD32BS3Kfg==
X-Received: by 2002:a05:620a:2949:b0:767:18f8:7b20 with SMTP id
 n9-20020a05620a294900b0076718f87b20mr9308102qkp.19.1688726163158; 
 Fri, 07 Jul 2023 03:36:03 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it.
 [79.46.200.163]) by smtp.gmail.com with ESMTPSA id
 cx18-20020a05620a51d200b007592f2016f4sm1671868qkb.110.2023.07.07.03.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 03:36:02 -0700 (PDT)
Date: Fri, 7 Jul 2023 12:35:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com, 
 mst@redhat.com, marcandre.lureau@redhat.com, stefanha@redhat.com, 
 viresh.kumar@linaro.org, takahiro.akashi@linaro.org, erik.schilling@linaro.org,
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Subject: Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user
Message-ID: <pc4akdgo5njdrcokvtqjggd4aycfjrb6jobwgwk5cr6asr5zun@krowoff46yae>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <873521f1c9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <873521f1c9.fsf@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

On Thu, Jul 06, 2023 at 05:31:15PM +0100, Alex Bennée wrote:
>
>Alex Bennée <alex.bennee@linaro.org> writes:
>
>> Currently QEMU has to know some details about the back-end to be able
>> to setup the guest. While various parts of the setup can be delegated
>> to the backend (for example config handling) this is a very piecemeal
>> approach.
>>
>> This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
>> which the back-end can advertise which allows a probe message to be
>> sent to get all the details QEMU needs to know in one message.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>
>> ---
>> Initial RFC for discussion. I intend to prototype this work with QEMU
>> and one of the rust-vmm vhost-user daemons.
>> ---
>>  docs/interop/vhost-user.rst | 37 +++++++++++++++++++++++++++++++++++++
>>  hw/virtio/vhost-user.c      |  8 ++++++++
>>  2 files changed, 45 insertions(+)
>>
>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> index 5a070adbc1..85b1b1583a 100644
>> --- a/docs/interop/vhost-user.rst
>> +++ b/docs/interop/vhost-user.rst
>> @@ -275,6 +275,21 @@ Inflight description
>>
>>  :queue size: a 16-bit size of virtqueues
>>
>> +Backend specifications
>> +^^^^^^^^^^^^^^^^^^^^^^
>> +
>> ++-----------+-------------+------------+------------+
>> +| device id | config size |   min_vqs  |   max_vqs  |
>> ++-----------+-------------+------------+------------+
>> +
>> +:device id: a 32-bit value holding the VirtIO device ID
>> +
>> +:config size: a 32-bit value holding the config size (see ``VHOST_USER_GET_CONFIG``)
>> +
>> +:min_vqs: a 32-bit value holding the minimum number of vqs supported
>> +
>> +:max_vqs: a 32-bit value holding the maximum number of vqs supported, must be >= min_vqs
>> +
>>  C structure
>>  -----------
>>
>> @@ -296,6 +311,7 @@ In QEMU the vhost-user message is implemented with the following struct:
>>            VhostUserConfig config;
>>            VhostUserVringArea area;
>>            VhostUserInflight inflight;
>> +          VhostUserBackendSpecs specs;
>>        };
>>    } QEMU_PACKED VhostUserMsg;
>>
>> @@ -316,6 +332,7 @@ replies. Here is a list of the ones that do:
>>  * ``VHOST_USER_GET_VRING_BASE``
>>  * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
>>  * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
>> +* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STANDALONE``)
>>
>>  .. seealso::
>>
>> @@ -885,6 +902,13 @@ Protocol features
>>    #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>>    #define VHOST_USER_PROTOCOL_F_STATUS               16
>>    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>> +  #define VHOST_USER_PROTOCOL_F_STANDALONE           18
>> +
>> +Some features are only valid in the presence of other supporting
>> +features. In the case of ``VHOST_USER_PROTOCOL_F_STANDALONE`` the
>> +backend must also support ``VHOST_USER_PROTOCOL_F_CONFIG`` and
>> +``VHOST_USER_PROTOCOL_F_STATUS``.
>> +
>
>This is too tight a restriction as not all VirtIO backends manage a
>config space. So I suggest the following:
>
>  Some features are only valid in the presence of other supporting
>  features. In the case of ``VHOST_USER_PROTOCOL_F_STANDALONE`` the
>  backend must also support ``VHOST_USER_PROTOCOL_F_STATUS`` and
>  optionally ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config space).

Right, but could we describe it more as a kind of dependence between
features?

Something like this:

Some features depend on others to be supported:

* ``VHOST_USER_PROTOCOL_F_STANDALONE`` depends on:

   * ``VHOST_USER_PROTOCOL_F_STATUS``
   * ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config space)

Thanks,
Stefano


