Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7427079E5AA
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 13:03:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgNeh-0000j4-Uf; Wed, 13 Sep 2023 07:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qgNeJ-0000Y5-5e
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 07:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qgNeD-0002CP-Bh
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 07:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694602984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z5gcQNTNLHmmy+uQMPBp920TBQ4Kf4a5M3vofMatqLM=;
 b=gKutuS8rALVGvc6FA0Tq/LFrH3abdN0R60qyLjcJh3AqWIj4YL3zQmcgqoXJhVopGI1FAz
 QCdfDTp2pqdOKdR08h9DM3rqQp2g/rrAKkBFYVmbC5raPS4wB4iZp+AhzhlKRqObiBLSm+
 I7QzRZ80In2cZdwuJmrQ3bW//FZ6IJQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-qEVuJrf3MXCz9DXZNQLXUQ-1; Wed, 13 Sep 2023 07:03:01 -0400
X-MC-Unique: qEVuJrf3MXCz9DXZNQLXUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14BD6805B32;
 Wed, 13 Sep 2023 11:03:01 +0000 (UTC)
Received: from [10.39.194.255] (unknown [10.39.194.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5632200A4B6;
 Wed, 13 Sep 2023 11:02:59 +0000 (UTC)
Message-ID: <611b3a2e-449a-dec3-84f4-ac344db07fad@redhat.com>
Date: Wed, 13 Sep 2023 13:02:58 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] hw/i386/pc: fix code comment on cumulative flash size
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-trivial@nongnu.org
References: <20230912155553.82514-1-lersek@redhat.com>
 <47336aed-d6e9-a844-d7ee-1f8944cbb882@linaro.org>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <47336aed-d6e9-a844-d7ee-1f8944cbb882@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 9/12/23 18:40, Philippe Mathieu-Daudé wrote:
> On 12/9/23 17:55, Laszlo Ersek wrote:
>> - The comment is incorrectly indented / formatted.
>>
>> - The comment states a 8MB limit, even though the code enforces a 16MB
>>    limit.
>>
>> Both of these warts come from commit 0657c657eb37 ("hw/i386/pc: add max
>> combined fw size as machine configuration option", 2020-12-09); clean
>> them
>> up.
>>
>> Arguably, it's also better to be consistent with the binary units
>> (such as
>> "MiB") that QEMU uses nowadays.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:PC)
>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:PC)
>> Cc: Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86 TCG CPUs)
>> Cc: Richard Henderson <richard.henderson@linaro.org> (maintainer:X86
>> TCG CPUs)
>> Cc: Eduardo Habkost <eduardo@habkost.net> (maintainer:X86 TCG CPUs)
>> Cc: qemu-trivial@nongnu.org
>> Fixes: 0657c657eb37
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> ---
>>
>> Notes:
>>      v2:
>>           - use the binary units MiB, KiB, GiB comprehensively in the
>> comment
> 
> I was going to suggest that ;)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

And when I was writing the patch, I was 100% sure that you were going to
be my first reviewer. :)

Thanks!
Laszlo

> 
>>
>>   hw/i386/pc.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
> 


