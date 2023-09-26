Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 588427AF18C
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:07:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBWU-0000a5-IZ; Tue, 26 Sep 2023 13:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qlBWS-0000Zl-0y
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 13:06:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qlBWP-0000Jk-KS
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 13:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695748012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4fV7nzP+/pZt5wUVrrxjeg+EljRasudVV0OsG85cYN4=;
 b=Az1AT3UJBy+gjetFwc2BW+HoXcUuI0dLv9jWeB+GRzCPMomkO5wcv5TABxoPEdNEmC4T+C
 ee7Q6tOBSQcoqT8ybLLqsvmQMhSU8+dWHDbXwLFz1TBqZaPQa6yCAjxgqq0bP3OhojOXHD
 O52U/LbhTOtZ1E9LXCJacdqkfauNCiw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-edMLd5lLPzeUU4v-lYVVfQ-1; Tue, 26 Sep 2023 13:06:51 -0400
X-MC-Unique: edMLd5lLPzeUU4v-lYVVfQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7742be66d25so172133985a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 10:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695748011; x=1696352811;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4fV7nzP+/pZt5wUVrrxjeg+EljRasudVV0OsG85cYN4=;
 b=sVs37azoYbD0qAIOyeZEDotqGYLIGPB/gsX6WuabCvvf/fCTQYeKfm2YbBX9+QrRed
 9opZ4sUS/CHT8yWC0GD8jzZAUFaJaV2vicTwzYiyJRLxMG9cdx6rD8Esz85K72QWLWt4
 92AMsbzOYEWHbIYrEztFF8RSK28F14lG3gEJdTd+qh6A7GZQ0vAeHtg2sJPUAyNsx91X
 XbZUeAkLhus4Ptx+9LNY8kT0MzN18gW/tTL9EUPjE6AxBWWMCBLLfgDAO+2V3XeJf2t4
 PiEHD+Ech5hFiYIOCV3kt1medJ9dmeNHcmRlZ8SEOd7nkA67EJrzDnjGhO7t0f8NZmWK
 porw==
X-Gm-Message-State: AOJu0YwhK7ef8p1Rz2wiWTT2k/n4mwDiRIGXp9i1F7u8ryd+znxTahzZ
 CCFyvQ1wBnTaJ1qMeZh+j4C+G/Xc9G3M/qRynd+Ef7UMd3CBxt5Bsw5ERgb1R2AITfsNmIHAp9Z
 d8s7EIjOHPfl5EjM=
X-Received: by 2002:a05:620a:178b:b0:773:a789:cd15 with SMTP id
 ay11-20020a05620a178b00b00773a789cd15mr10752907qkb.6.1695748010742; 
 Tue, 26 Sep 2023 10:06:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlkrh9/YqWQKPsdsU9+fkzZVriYNVhD/NWnD77cA4uY2o3a7iWk5fpb5OSAfsu7haO2rwr7Q==
X-Received: by 2002:a05:620a:178b:b0:773:a789:cd15 with SMTP id
 ay11-20020a05620a178b00b00773a789cd15mr10752872qkb.6.1695748010370; 
 Tue, 26 Sep 2023 10:06:50 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 ow10-20020a05620a820a00b0076d9df37949sm4885520qkn.36.2023.09.26.10.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 10:06:50 -0700 (PDT)
Date: Tue, 26 Sep 2023 13:06:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 0/4] qapi/migration: Dedup migration parameter objects
 and fix tls-authz crash
Message-ID: <ZRMPp6aoi7LUPMfK@x1n>
References: <20230905162335.235619-1-peterx@redhat.com>
 <87jzsetnm5.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzsetnm5.fsf@pond.sub.org>
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

On Mon, Sep 25, 2023 at 02:59:30PM +0200, Markus Armbruster wrote:
> Peter, looks like you missed my review of v2.

I definitely missed that if there is, but I didn't see any, and also
nothing I spot on the list, either..

https://lore.kernel.org/all/20230825171517.1215317-1-peterx@redhat.com/

Could you share a pointer?

Thanks,

-- 
Peter Xu


