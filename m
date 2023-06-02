Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5A271FDBC
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 11:24:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5115-0005uD-Hg; Fri, 02 Jun 2023 05:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q5111-0005tq-4r
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:24:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q510z-0002Ib-GQ
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685697848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c9Cmi45a95gnTo6HSCqEp6jmdL96wucdfv8a9CKKDJI=;
 b=UDNHu8ft7ZQSk/0Th8UCWQHiAG4XN1co5ejHlXnKnoE/N9dWiSsw5J0h3mYcSro9/FHsbA
 z3fsYmFL0b7SGO9I49kaj5OOGdZ2MhP2D/x/vWPKOLZxvc9bjHCBqYsvk8Hp9oOpeYTnvW
 LORyKaJ7HgxmUTHnx7jt3axaa34btCE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-Sjx6DywTMtGoZ-_BqxzhJQ-1; Fri, 02 Jun 2023 05:24:03 -0400
X-MC-Unique: Sjx6DywTMtGoZ-_BqxzhJQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30a5d4e5731so958443f8f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 02:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685697842; x=1688289842;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c9Cmi45a95gnTo6HSCqEp6jmdL96wucdfv8a9CKKDJI=;
 b=YOI96zPefAe6gBZld7mKbm6Q39z6A55VPspeOKSCssDS8VSOLeiCPBvVMTSWIqSieA
 MyGh+H4t2RBnpEUsGafEQNnkRq9xTnw1r6neXcz/Q2GRmdMuuAizOaCJcyfoHFHHvKKb
 T6/1yFqrVEEFLisq9ACkvb1SO6IU0SAl4zZ4AaTpEdleJ7gKONHaEzRQAVMseG8YTuqF
 XKAyfoTI0Xh0jv1ySvZAiJks0wH1ZA6NW6EjIJxzpznK+7/jVczcFCx3kEloSIzGdnhy
 dcoR5OSobHf+lOUvaQPcRlStljtFUPTcjarp+yE2JAOF/CoP0fH4MyljzZqaZl3jNJoW
 DxQg==
X-Gm-Message-State: AC+VfDwzP2UzbvlPqzdwdPCSzqLAND41Jaizws1YoE/4LLr8CNU5vLpN
 +NyogGmV2YzJSBf6GjqByhGT18pCIuP7f7yvhoZ4OCKNUf7JvFqmgRNyAsyYUo34VDv89zDwsq/
 Bc6kQtxabcrq84wc=
X-Received: by 2002:adf:ee8e:0:b0:2f5:930:39b1 with SMTP id
 b14-20020adfee8e000000b002f5093039b1mr3726973wro.38.1685697842789; 
 Fri, 02 Jun 2023 02:24:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ78ehPC8iQKU40c1DXtRAczH4ilBdy7QnuycXfGiQrJA9OGS/I4w7hYVdBEhV4nlMOBWxYuhg==
X-Received: by 2002:adf:ee8e:0:b0:2f5:930:39b1 with SMTP id
 b14-20020adfee8e000000b002f5093039b1mr3726956wro.38.1685697842507; 
 Fri, 02 Jun 2023 02:24:02 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-14.web.vodafone.de.
 [109.43.176.14]) by smtp.gmail.com with ESMTPSA id
 m4-20020a5d6a04000000b0030aea925fbesm1104766wru.50.2023.06.02.02.24.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 02:24:01 -0700 (PDT)
Message-ID: <ae4540a2-f4d1-aece-d1e5-d631d9814233@redhat.com>
Date: Fri, 2 Jun 2023 11:24:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Big TCG slowdown when using zstd with aarch64
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Richard Henderson <rth@twiddle.net>, Peter Xu <peterx@redhat.com>
References: <87y1l2rixp.fsf@secure.mitica> <ZHmyA40nIiUBceX0@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <ZHmyA40nIiUBceX0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 02/06/2023 11.10, Daniel P. Berrangé wrote:
...
> IMHO this feels like just another example of compression being largely
> useless. The CPU overhead of compression can't keep up with the guest
> dirty workload, making the supposedly network bandwidth saving irrelevant.

Has anybody ever shown that there is a benefit in some use cases with 
compression? ... if not, we should maybe deprecate this feature and remove 
it in a couple of releases if nobody complains. That would mean less code to 
maintain, less testing effort, and likely no disadvantages for the users.

  Thomas


