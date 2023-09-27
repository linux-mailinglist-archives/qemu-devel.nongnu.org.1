Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2607F7B07EE
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 17:16:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWGZ-0001Yl-9j; Wed, 27 Sep 2023 11:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qlWGN-0001Xk-Fc
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:15:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qlWGL-0006gJ-QQ
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695827740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3z85TRzBm6UHQguifz5wgCkOALA35VAG0hTc2WkFh0=;
 b=LPOSQZ3c+JVFrqWDLmzdq/2P85jmehjomKa2SoBTDriGq4tRpmRLr0H6y2dmKLgkW2+O3F
 N77JDNJzapbK313OgMCf8GuMnt3JloHToXyNuU4diFxEq/YUXpwiw71DZJKe18DmcOKaCE
 zwCU/82b0OSS8yT/oJN0/SWOzzUVF/w=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-J9ERx5hbPeGDsQsZZVdorA-1; Wed, 27 Sep 2023 11:15:39 -0400
X-MC-Unique: J9ERx5hbPeGDsQsZZVdorA-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-495fe2e308cso1394651e0c.1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 08:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695827738; x=1696432538;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+3z85TRzBm6UHQguifz5wgCkOALA35VAG0hTc2WkFh0=;
 b=xQq67FRspuEqfGRNt7+jY5cMaPMnw+fyl+AjU51sNEnOvHWE9/ckhPcUXiHXK73unx
 26uP5tBdWbRrvZhvQcegdTIQ34EaIOeqkrWP0fffPEOybrIsH7bkmpFnzKt1sk7hHz7k
 MkPGcKr+ulBiOwcGuwdi5JnCTDGMWOlV9M/IOvFI08bFGxKufmW3schEfS82+DvXXuWw
 XHdprqnQ8JE1WQdVAbm2gcGqD61AXR5QIhmC2aN/sam8RfqX9BlvjgPCP1Mahs4Dhscy
 2y2WFNBeSyYjfGJIBnJ86DG18Acf6YDLZ8z7W/e4lKYEvCK08+fHKxGZ/tWomv8W7C6j
 GuLQ==
X-Gm-Message-State: AOJu0YzAIC6w6urNEoS57G0cdnAdrE9jVyOZVr2+tEg2i1YBZtlxElDD
 DCjfLgV1aKxZqJecvci2BJNPH6mR+pRexmaDKxTw8U+rtCSNGlDZIvEJlHjtS35jkPUCd92ij6z
 e5ZaS4tQOo17QLPI=
X-Received: by 2002:a05:6122:1191:b0:49a:628f:ee34 with SMTP id
 x17-20020a056122119100b0049a628fee34mr1243270vkn.0.1695827738521; 
 Wed, 27 Sep 2023 08:15:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqGr3i2gT9S5sAURjFWG0jSAHWvbg81nepEllVN4ksZeD9rlldvhwI/H14KZ1RFbEwn4MJsQ==
X-Received: by 2002:a05:6122:1191:b0:49a:628f:ee34 with SMTP id
 x17-20020a056122119100b0049a628fee34mr1243250vkn.0.1695827738207; 
 Wed, 27 Sep 2023 08:15:38 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 jx18-20020a05622a811200b004180fb5c6adsm3250827qtb.25.2023.09.27.08.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 08:15:37 -0700 (PDT)
Date: Wed, 27 Sep 2023 11:15:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Claudio Fontana <cfontana@suse.de>, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: migration maintenance, governance [Was: Re: [PATCH V4 0/2]
 migration file URI]
Message-ID: <ZRRHFyPC4wyyOUhx@x1n>
References: <1688135108-316997-1-git-send-email-steven.sistare@oracle.com>
 <dba1e07d-6ebf-9329-7be7-4702ff5dc16d@suse.de>
 <1290963e-9f63-fc70-6729-d355d247c2fd@linaro.org>
 <2f5b9774-e089-3606-905a-8b991dcc5e87@suse.de>
 <a4adf886-7018-4cf5-14d6-cd85172ea501@suse.de>
 <9833202a-8060-1e81-208e-4e240279c298@suse.de>
 <ZRQ0nOssnc0rdw6m@x1n> <ZRQ94J9vv83nLI4V@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZRQ94J9vv83nLI4V@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Sep 27, 2023 at 03:36:16PM +0100, Daniel P. Berrangé wrote:
> Even if not actively sending a PR, a possible starting point that could
> be done today, would be for someone to put up a gitlab.com branch that
> contains all the outstanding patch series that are considered ready
> to merge and validate a CI pipeline. That would both serve as a base for
> further work, and might be useful to Juan in assembling the next pull
> request.

Right.

Though that'll be slightly conter-productive if Juan already has a branch
that contains everything for a pull covering patches until two weeks ago.

I think before he left he has that on hand, maybe also tested a bit over
the branch.  I actually talked to him on taking that branch over for this
time if he's busy, but unfortunately that conversation discontinued..

Having another branch has the risk that we'll have two base branches, if
Juan's branch will be sent out as the final pull next week and get merged.

But I do agree things need to be done if the pull doesn't come next week.

Thanks,

-- 
Peter Xu


