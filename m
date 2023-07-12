Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C31D750AF1
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 16:27:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJao1-0006Y5-ET; Wed, 12 Jul 2023 10:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qJanx-0006Xg-9O
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 10:26:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qJanu-0006Kf-6b
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 10:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689172013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RxadBZ/e9+iHxmAJkMx44y3xAiAtBYZJ7/ie6q6tPng=;
 b=W3r/nmvD0H+4muI1dhNo/vIGgkPsHfAD05/Rrw91173eOfvvpUAgTyc2Idc6wWqZ1xlicE
 I8CKD5u1oiVkmEGJ41ZM7r/kLd1cYcVUj8u54HC1unVUWb2sAv2McJwB/eaHIB3CFqQiRQ
 wXN+WPjm3zLSHqaBWGZRkrgQEy+QcMs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-HCxHGrwCNbCsL1CRkSq1Ew-1; Wed, 12 Jul 2023 10:26:52 -0400
X-MC-Unique: HCxHGrwCNbCsL1CRkSq1Ew-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4fb9364b320so6442742e87.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 07:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689172010; x=1691764010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RxadBZ/e9+iHxmAJkMx44y3xAiAtBYZJ7/ie6q6tPng=;
 b=da5P6uFrsK3b0ekWbjEq20T/qVk//Ay4MAc+gg9dFTaCaohzfzXPHuq3pz01gmPO55
 ed4rXixMGSSPc2p61nOLspXSXYhjsZLHrVhZuUsMCQe/hQru9nm5yK+XgAjJ0gUbbq6a
 zRnNyS8QANcNe67dOaQIOzKWYt0Zhmilv2kM65qsDeyHeO8ALpRJIO0S5mPxqzb2tEgU
 Rlad2qphhc0VX9TvW+ZZptVIjKDlWFtSGDivShY6wai/+LIz4rmhZYRqMSA1tC+nT7Pz
 gXfMkt1XPd7J1sGWU4eUXW2KiidxyuuqLwNngcBW4eJ693Lk6Gw+0dKuH9PXjfPWqQRv
 nPCg==
X-Gm-Message-State: ABy/qLZgMtcnVrZxsJfNgBBV5MdsPE8sJpiqeUlbT4cpwKO5qDT66PA7
 MC8JDPUK9sQndBnPzZwFeiiC5aeGN7YLq2CpUj2jKKcLz2Woyve5HAtphFkzfRSm32zQxt4TJQU
 9dQYb52KnrxqRujY=
X-Received: by 2002:a05:6512:1289:b0:4fb:745e:dd01 with SMTP id
 u9-20020a056512128900b004fb745edd01mr19236033lfs.45.1689172010763; 
 Wed, 12 Jul 2023 07:26:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFkNsKPYxzyCKFBFzT2Ba1WmnPb2DW9qQiaMClrU8mrzLR7F2hdclCVyqYRAUgqznT8iViyTw==
X-Received: by 2002:a05:6512:1289:b0:4fb:745e:dd01 with SMTP id
 u9-20020a056512128900b004fb745edd01mr19235999lfs.45.1689172010429; 
 Wed, 12 Jul 2023 07:26:50 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c?
 ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.googlemail.com with ESMTPSA id
 v6-20020aa7cd46000000b0051e3385a395sm2904335edw.3.2023.07.12.07.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 07:26:49 -0700 (PDT)
Message-ID: <07672031-3e89-a221-b580-40fed4bce394@redhat.com>
Date: Wed, 12 Jul 2023 16:26:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 linux-scsi@vger.kernel.org, "Martin K. Petersen"
 <martin.petersen@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org,
 "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
 <CAJSP0QX5bf1Gp6mnQ0620FS61n=cY6n_ca7O-cAcH7pYCV2frw@mail.gmail.com>
 <v6xzholcgdem3c2jkkuhqtmhzo4wflvkh53nohcgtjpgkh5y2e@bb7vliper2f3>
 <ZK6tRDwxgbyYfv2v@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ZK6tRDwxgbyYfv2v@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.11, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/12/23 15:40, Christoph Hellwig wrote:
>> The problem is that the SCSI stack does not send this command, so we
>> should do it in the driver. In fact we do it for
>> VIRTIO_SCSI_EVT_RESET_RESCAN (hotplug), but not for
>> VIRTIO_SCSI_EVT_RESET_REMOVED (hotunplug).
>
> No, you should absolutely no do it in the driver.  The fact that
> virtio-scsi even tries to do some of its own LUN scanning is
> problematic and should have never happened.

I agree that it should not do it for hot-unplug.  However, for hot-plug 
the spec says that a hotplug event for LUN 0 represents the addition of 
an entire target, so why is it incorrect to start a REPORT LUNS scan if 
the host doesn't tell you the exact LUN(s) that have been added?

There is a similar case in mpi3mr/mpi3mr_os.c, though it's only scanning 
for newly added devices after a controller reset.

Paolo


