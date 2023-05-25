Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CE1710C47
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:45:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2AL7-0006da-Qq; Thu, 25 May 2023 08:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2AL4-0006af-AO
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2AKs-0000tH-1u
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685018691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BBNRQ3NjgiL0Rq9L+84UlRsJOqmrsIqjTi4yn7L/pjQ=;
 b=Goh83m9H6WJFShkDc+t/ccmpJkB6jRvzAoCgOvIm9O/pBKbI9jDWXtYG/UPuwsndyV3gO4
 BT3jvvvuy5jr+vj4Ifs5oUBoAm0xWNboSXY4HW4DegIoGxTJma4HAfCXXj8LZCRFh74ryj
 DRSB1Si8iz8KxsadZYArKUpj+dU31VQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-rMEJMwd3MQG4FiNGZH5bYQ-1; Thu, 25 May 2023 08:44:50 -0400
X-MC-Unique: rMEJMwd3MQG4FiNGZH5bYQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-74faf5008bbso47298785a.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 05:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685018690; x=1687610690;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBNRQ3NjgiL0Rq9L+84UlRsJOqmrsIqjTi4yn7L/pjQ=;
 b=R25IBPSwxJ1QDC9f4Z/BuikcvoH6eoY+nI3TlTYkF/E42QNtam7IAb5sxHfpZq4DRs
 IewMM6ApzlDnJEXXZyTGFpEfgUTaOhyzGik9Y59+438krQtKbgR0Bf0xDmWL+Or/Ykhb
 hQzmEFODga2ExYV3SEF5vqC1cc1qnhcJBXLST136M8rW/zkkAPr3Z14BNLs2uJDvpgZy
 RtXj6OWM+MzFNvLf9yoR9GRbBatdxBSo/pie6N8t+67DXYvsdvQwQ/igqkNZm+dAVAxf
 8Ib4H11P3TZ/2jPVsV0IM+GZ3h5i0Z3ixZO/Vo7qmTh6qWPuUk5bFysrcxzDtkEiKoO3
 w4dQ==
X-Gm-Message-State: AC+VfDytEi8SX29DZB32un+I5X9M+9qnSAdnBNohFew9VUA35tKSbQWR
 Ff5ExP+49CyT0xAFaxJZhjAanNQ0HazHqkHbqdUoZPbOL7+vI6ydMQUQbzFeX4hYcHFlinV5e2Z
 cu6sJIzI4ql3x+mg=
X-Received: by 2002:a37:603:0:b0:75c:9cba:3768 with SMTP id
 3-20020a370603000000b0075c9cba3768mr1478578qkg.4.1685018690035; 
 Thu, 25 May 2023 05:44:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5QMix6kr+70QzIHmbbAhAjau4cyUaGWk/GuvCCIX6H8IHTOkZKBN6SAxs78gvZt4AWfiY1jQ==
X-Received: by 2002:a37:603:0:b0:75c:9cba:3768 with SMTP id
 3-20020a370603000000b0075c9cba3768mr1478559qkg.4.1685018689756; 
 Thu, 25 May 2023 05:44:49 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 u22-20020a05620a121600b007579ff44f0dsm345169qkj.124.2023.05.25.05.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 05:44:49 -0700 (PDT)
Date: Thu, 25 May 2023 08:44:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v3 2/7] migration: Implement switchover ack logic
Message-ID: <ZG9YP45oULV3YJl4@x1n>
References: <20230521151808.24804-1-avihaih@nvidia.com>
 <20230521151808.24804-3-avihaih@nvidia.com> <ZG5mOKlGtQEyywyQ@x1n>
 <541dc36f-618e-a2c5-a27f-51db65abecbd@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <541dc36f-618e-a2c5-a27f-51db65abecbd@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, May 25, 2023 at 12:51:46PM +0300, Avihai Horon wrote:
> However, there is one issue -- we can't send the ACK up here [1], as at that
> point the return path has not been created yet.
> A possible solution is to check for mis->switchover_ack_pending_num == 0
> when we create the return path and send the ACK there.
> It's not as clean as checking the number of users and ACKing here in the
> same place, but it works.
> 
> Do you think it's OK? or do you have another idea?

Good point. It looks fine to me as we create the return path mostly at the
very early stage right after the migration headers.

Let's just add a comment describing the ordering fact?  IMHO it's about
switchover_ack_pending_num won't be used before setup of the return path
due to current wire protocol (we create return path before sending mostly
anything else), so setup it there is fine.

-- 
Peter Xu


