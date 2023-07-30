Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A676867E
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 18:46:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ9BU-0007La-CJ; Sun, 30 Jul 2023 12:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qQ9BS-0007LB-2w
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 12:22:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qQ9BQ-0007V7-LF
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 12:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690734134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iTRGwst2FYrFX8bNZZC4poz4bt4gXBHX3mGxp1exduQ=;
 b=QDeJ7CjWGtqNCn3Fk2zv/yY243CVmOEKHHdm3UWORyPEvna5wn5tv6LmeqSDEOmiAX9aKS
 SY3Xq7mLCtbZ7hQVYsrh/YQ5Mll0FmfnY/JRCfqwUJWRpICiv4ZIeT6mgBGFzenwktp6KS
 BvhdKkbTckzzjTKo0wrLYi9mXeuLCk0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-rn1afPLYNMiSiUhKMRFF1w-1; Sun, 30 Jul 2023 12:22:12 -0400
X-MC-Unique: rn1afPLYNMiSiUhKMRFF1w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbe356b8deso22144315e9.0
 for <qemu-devel@nongnu.org>; Sun, 30 Jul 2023 09:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690734131; x=1691338931;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iTRGwst2FYrFX8bNZZC4poz4bt4gXBHX3mGxp1exduQ=;
 b=aJVLWyzm/AXVxdr+xZrqXPcz3Mt7thFm5xnfBhzePESN1mZmORnKHYPJDQZK3+YT+S
 lG2dIjo/P8F3DkhpGC7WhaO5xUwb/k4TA+5JwkeTS4dgqce/gIkJi2KsZZyl9/j82Hrf
 TSYRCXpiuUtjclVfUze6kOGy2vobbPCQwsNdmaMxaGLG2BkX/3fnWT2lxKUCu+3FC/po
 bnL2OKaMTsO0hqQETYS1HkASHh3kPGgfQRdZro7d0UNoFYKFfvDnKWJaTJWOAZ99gJrJ
 mgRhmD76JnzMKQdQ7sXWrB7UqLZiR8yUk4bTTLZkXpZmU/0ftdqXnSwAi3EQhXwWu2vi
 tG8A==
X-Gm-Message-State: ABy/qLag84mo1Z45xJskhUb9pT5JXGFTBTxaZ1cPFwT8I7i6FDbEEoin
 1dtlYcbWeRZKzdUEM/Nlq8zy/G6crus+G06YoTBKQ3enbjXVK1FFaWhHqZJkMItqRDxwi3MXtDL
 jtJ76mARnSnOM7Ms=
X-Received: by 2002:a5d:40c4:0:b0:317:943:eaf1 with SMTP id
 b4-20020a5d40c4000000b003170943eaf1mr5149193wrq.28.1690734131359; 
 Sun, 30 Jul 2023 09:22:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGKPQy9DunlF7OPCVdLzne+HRRhEONGKtPG9VF0lE+fLjW4Y56usjeiNlrlRR2hmfbKvqcUVg==
X-Received: by 2002:a5d:40c4:0:b0:317:943:eaf1 with SMTP id
 b4-20020a5d40c4000000b003170943eaf1mr5149181wrq.28.1690734131062; 
 Sun, 30 Jul 2023 09:22:11 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891?
 ([2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a5d6b87000000b003175fef2a32sm10442112wrx.55.2023.07.30.09.22.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jul 2023 09:22:10 -0700 (PDT)
Message-ID: <290ed971-1fe9-c61d-d79c-29d3623aa32d@redhat.com>
Date: Sun, 30 Jul 2023 18:22:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 2/6] sysemu: Add pre VM state change callback
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Yishai Hadas <yishaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>
References: <20230716081541.27900-1-avihaih@nvidia.com>
 <20230716081541.27900-3-avihaih@nvidia.com>
 <ea781305-fba3-83eb-aac9-fdef6a81b5c9@redhat.com>
 <0562c698-3223-005a-e63d-ec94126f0448@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <0562c698-3223-005a-e63d-ec94126f0448@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

[ ... ]

>>> + * qemu_add_vm_change_state_handler_prio_full:
>>
>> qemu_add_vm_change_state_handler_prio_all() may be. I don't have much better
>> but 'full' doesn't sound right. minor.
> 
> I followed the GLib naming convention.
> For example, g_tree_new and g_tree_new_full, or g_hash_table_new and g_hash_table_new_full.
> I tend to go with GLib naming as it might be more familiar to people.
> What do you think?

Let's keep it then.

Thanks,

C.


