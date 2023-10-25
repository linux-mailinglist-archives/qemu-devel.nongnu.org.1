Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 920D27D6614
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:02:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvZlI-00029t-VH; Wed, 25 Oct 2023 05:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvZlG-0001zT-HZ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvZlC-000589-6j
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698224464;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Y50aWAl7HBsejPWjmrUN+bpGpHWEsc2mKwJJZZCKq5k=;
 b=WN0QAcVcVjDYdh5nyk5YzBso87vqmtMDi6Jjzm8Frc1SUa9bKy8y14AgfNfplIy6Aw+Fvk
 190A8nDIp1QI487IP9a9iNcEGmj9jljQbaosaLjM3lPJpbNhCgVL2PfIsx5RZS0L0PiAKV
 6kV0nqmCpTSb7EZZ3Y0uIQNgqKlTcCs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-dEbAVuGWO-uVdDHX3VVtQA-1; Wed, 25 Oct 2023 05:00:57 -0400
X-MC-Unique: dEbAVuGWO-uVdDHX3VVtQA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4083a670d25so38446635e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 02:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698224456; x=1698829256;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y50aWAl7HBsejPWjmrUN+bpGpHWEsc2mKwJJZZCKq5k=;
 b=JRhgkPqZX9GjGodJNqr+8iqE2DmAQntZKkg6/IpGA3DT32mjQBK7elnlDI8pXYldHW
 DVcsnw2wnEoCWcg5nPvVWwaczzL8BzDhvqHOPJoQTUpyyl5TFNMZtEVEeWgD8SNGdpuS
 GuI9bMvV2g7IMOhp3jtsve4JLyHMJaKw0F0j9Hd3pHgtAzQbT89KS6eBB2TDrbIh9GNd
 tz5qejjPKL2qdGl5a2CGXAzTuULtVZAkjldWW/rQXdB1hNESVwGACUWYs/nWUulA4wHb
 b50PLcrIPtzMxKu3OlECnRFBgOV9+rQB3dGRXHpB+y6esmapMTO1DXL6rAOB7rMFk6xY
 d55A==
X-Gm-Message-State: AOJu0YxYIr0mUIbwctGJhovSTnAAei1xt6LkDZ8QnJyR2zx/ks4W5roo
 yixdfIfFtLeWOnZRCtUzR0klY9ci7wm4rFMC9yu+9OGfk5yEnpWUK6WhnNhYg9RsFIq6HcBwdsP
 lRB6Euojvf7r3X3c=
X-Received: by 2002:a05:600c:470e:b0:408:543d:5536 with SMTP id
 v14-20020a05600c470e00b00408543d5536mr10838978wmo.4.1698224455559; 
 Wed, 25 Oct 2023 02:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/4FhtvfABzqNMo5Buv5eH4TbkTQUOVBqMhb2kP04axOPNpLD09sAEla23d9gC8SOGf0CyOA==
X-Received: by 2002:a05:600c:470e:b0:408:543d:5536 with SMTP id
 v14-20020a05600c470e00b00408543d5536mr10838962wmo.4.1698224455269; 
 Wed, 25 Oct 2023 02:00:55 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 r6-20020a5d6946000000b00318147fd2d3sm11561796wrw.41.2023.10.25.02.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 02:00:54 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Peter Xu <peterx@redhat.com>,  Li Zhijian
 <lizhijian@fujitsu.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 01/12] qemu-file: We only call qemu_file_transferred_*
 on the sending side
In-Reply-To: <87a5s8szlz.fsf@suse.de> (Fabiano Rosas's message of "Tue, 24 Oct
 2023 14:24:08 -0300")
References: <20231024151042.90349-1-quintela@redhat.com>
 <20231024151042.90349-2-quintela@redhat.com> <87a5s8szlz.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 25 Oct 2023 11:00:54 +0200
Message-ID: <87cyx3f54p.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fabiano Rosas <farosas@suse.de> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> Remove the increase in qemu_file_fill_buffer() and add asserts to
>> qemu_file_transferred* functions.
>
> Patch looks ok, but I would rewrite the whole commit message like this:
>
> Don't increment qemu_file_transferred at qemu_file_fill_buffer
>
> We only call qemu_file_transferred_* on the sending side. Remove the
> increment at qemu_file_fill_buffer() and add asserts to
> qemu_file_transferred* functions.

Changed the commint text.

Thanks,


