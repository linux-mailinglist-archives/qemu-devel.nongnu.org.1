Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C68AC709696
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 13:33:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzyLo-00040Y-J1; Fri, 19 May 2023 07:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzyLk-00040F-Ky
 for qemu-devel@nongnu.org; Fri, 19 May 2023 07:32:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzyLi-0007NQ-I0
 for qemu-devel@nongnu.org; Fri, 19 May 2023 07:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684495961;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=KZ0n9pthhX0n2ApULG5jEUaKlMKUDnYoAcr+VLNgDyM=;
 b=HKM65W9nY1EPvPKgFYT2H8FqMJUbO/ClFLqNZTJl0Dsnxritg+OZmGgyN1wHH7xokBmKCu
 PWCaE3Hk9I0l95vMTdC5Gb4G7+CvF4v1bsjQXzMdxkKNEkUGupsNK2zK5ytcxjC9pBnTxh
 DJER5PC2jUlk+nGfxymdD5NRmm2Pho4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-FGXPVzAJNM2FSBbhYGN8ng-1; Fri, 19 May 2023 07:32:38 -0400
X-MC-Unique: FGXPVzAJNM2FSBbhYGN8ng-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-307bac4c949so1987971f8f.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 04:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684495957; x=1687087957;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KZ0n9pthhX0n2ApULG5jEUaKlMKUDnYoAcr+VLNgDyM=;
 b=MwrO7iqR+q0iO5HUDb2EY1I4w0LiGjsE0laeO4cAvVKp8xni6RjeAwJP5EGfYT3irN
 /noUxB4c8C+dTqzwI0Rsn0aTlN09R5zec4RMWDdRtrrCHAqaeOybrJBmq6EIj7rT5Sa9
 8dIWBmDSb5QVAVRGpGQaRgzZecQYjFsbEQ6K1DtkSKYPvkRN+jx4sgzRo1+Hw/d9Vown
 3BfeGVIPrvn/Ct/Gv/yu1ZFW2GlfwMAMEjnCK+SN2R3ZbA0RnDqKUfRuLSJnrStwOjRc
 CBOddfh+jEPoR9WPcUgDW4nNsOLrjqml3WSJr1Pb6uhSIRKP6Tga1ogo7rYPmWC+gyuO
 oPGA==
X-Gm-Message-State: AC+VfDzdTRrgqqmGegu8hER0+DLVWcwQEEoGPnr++l6ece1JoXEyRuWD
 /fRwindyNCRz1v3jpvCx57YAHbjtlDhrgCsZYlqm1+6QgI60K7g9DO3WIT6QNQCmlEAI9YoYIqw
 75InXI0jWljI5jcs=
X-Received: by 2002:a05:600c:2214:b0:3f3:468d:d017 with SMTP id
 z20-20020a05600c221400b003f3468dd017mr1124347wml.6.1684495956912; 
 Fri, 19 May 2023 04:32:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ46PR25CtQsBGEC2kUvkg9ZJE4QSdWo8BD4mAHbtrVx+C9/WrHGVj0eX/ILpdGcPfC69EIbEw==
X-Received: by 2002:a05:600c:2214:b0:3f3:468d:d017 with SMTP id
 z20-20020a05600c221400b003f3468dd017mr1124334wml.6.1684495956637; 
 Fri, 19 May 2023 04:32:36 -0700 (PDT)
Received: from redhat.com (84.125.95.163.dyn.user.ono.com. [84.125.95.163])
 by smtp.gmail.com with ESMTPSA id
 y14-20020adffa4e000000b00306281cfa59sm5052728wrr.47.2023.05.19.04.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 04:32:35 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "Wang, Lei4" <lei4.wang@intel.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>,  "Daniel Berrange"
 <berrange@redhat.com>
Subject: Re: [PATCH] multifd: Set a higher "backlog" default value for listen()
In-Reply-To: <DS0PR11MB63736463A526A0D1A0D64568DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
 (Wei W. Wang's message of "Fri, 19 May 2023 03:33:22 +0000")
References: <20230518085228.172816-1-lei4.wang@intel.com>
 <87h6saf18t.fsf@secure.mitica>
 <9def6eb4-e317-2b6d-87ab-d0aa34ea3afe@intel.com>
 <DS0PR11MB637345417B81FF5637B2D7D8DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <bc6f6fdb-ebf9-387b-9d56-5c61095a9473@intel.com>
 <DS0PR11MB63736463A526A0D1A0D64568DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 19 May 2023 13:32:33 +0200
Message-ID: <87fs7sy2su.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

"Wang, Wei W" <wei.w.wang@intel.com> wrote:
> On Friday, May 19, 2023 10:52 AM, Wang, Lei4 wrote:
>> > We can change it to uint16_t or uint32_t, but need to see if listening
>> > on a larger value is OK to everyone.
>> 
>> Is there any use case to use >256 migration channels? If not, then I suppose
>> it's no need to increase it.
>
> People can choose to use more than 256 channels to boost performance.

See my other email, I doubt it any time soon O:-)

> If it is determined that using larger than 256 channels doesn't increase performance
> on all the existing platforms, then we need to have it reflected in the code explicitly,
> e.g. fail with errors messages when user does:
> migrate_set_parameter multifd-channels 512


(qemu) migrate_set_parameter multifd-channels 300
Error: Parameter 'multifd-channels' expects uint8_t

So I think that is working.

>> 
>> >
>> > Man page of listen mentions that the  maximum length of the queue for
>> > incomplete sockets can be set using
>> > /proc/sys/net/ipv4/tcp_max_syn_backlog,
>> > and it is 4096 by default on my machine


