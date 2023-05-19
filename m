Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E907091BA
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:31:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvVv-0007aL-V5; Fri, 19 May 2023 04:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvVs-0007ZW-TY
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvVr-0004OK-Im
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684485058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYhukvTLxd5vY8IT0HgTeoW1864tkNJT6D8/3hlKdAo=;
 b=RHVhAf7OjRQYHSOr6csga+qbirU6r/tIi2J9EJ3si/SEey+DBQ6gaAWgp5HfA2r7/ihTfH
 83VwmWz2Jp33dwchEzaKeZNX5N6XPir64ZWj7q9CIc/bt1sKwr/L48+5pPvJEmHkgOwQd2
 ESJi1aITRszpu/XD+/HntYO7X1d139w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-fLppPjmfOYmyrw41P1pcaA-1; Fri, 19 May 2023 04:30:57 -0400
X-MC-Unique: fLppPjmfOYmyrw41P1pcaA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-510eb233a81so1445003a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 01:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684485056; x=1687077056;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zYhukvTLxd5vY8IT0HgTeoW1864tkNJT6D8/3hlKdAo=;
 b=lZVg/s/aPR2rlee8P9EtV40ozNZuoZTLcU4xmI8RuTn5ZT5XfzKYI7TXcL9OATzCuY
 sMSWOxFMPJR1xuLRNIVg54bgh9EQqDEenhPsa9UIRM3mljOQ8gp0oes12mqTzyw/m98u
 frJoilmp7aOZUt7+vnOzf9Tmj8+rUh4/bYGmJ+0m5T3xSSpfp2lmLm40X34hwS6fuaw9
 Yk96adTAgATnYTY6kXp1YLLei4Hic+kAS01o5fCtaMtxxhGZQmK63M0N2YvAfj1PbFoC
 m34Fvdnw4yuK0qZGLGhJkifSE/8k3KzRiBAGgWOvrx822sc/GsqqLABnYaBBS0raT5Us
 E8gA==
X-Gm-Message-State: AC+VfDyCiOKNEIehCd///D1gB1CLk8fy67gkosEoaHMYW+DFH39KSsB8
 WKRyj14FlguCvYqeYAamlDofqoFf2FiDEGzqiMBtf5jb7mW0PRLcJtIXwcZg0XxIWNcLyPujrQ3
 XeLX6xv03N18gpD9/lTEmubg=
X-Received: by 2002:a17:907:9809:b0:96b:207:a894 with SMTP id
 ji9-20020a170907980900b0096b0207a894mr804601ejc.1.1684485056043; 
 Fri, 19 May 2023 01:30:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7oLNgcyYiZ2fMfLVvEQ+uq6QhjOZVrGyAD51HHHgDvj0r1LTX1kCF1FFcNhDFTtCaFMsXd6Q==
X-Received: by 2002:a17:907:9809:b0:96b:207:a894 with SMTP id
 ji9-20020a170907980900b0096b0207a894mr804583ejc.1.1684485055690; 
 Fri, 19 May 2023 01:30:55 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 j4-20020a170906830400b009658475919csm1320778ejx.188.2023.05.19.01.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 01:30:55 -0700 (PDT)
Message-ID: <81e3dd08-1927-241e-2fe2-343e0f815acb@redhat.com>
Date: Fri, 19 May 2023 10:30:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Configure no longer works after pulling in the latest QEMU commits
Content-Language: en-US
To: Hao Xiang <hao.xiang@bytedance.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jsnow@redhat.com" <jsnow@redhat.com>
References: <CAAYibXhsM8rWghEtUoehodK1u+SZ5of81vA-gshmTWiH7PvbLg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAAYibXhsM8rWghEtUoehodK1u+SZ5of81vA-gshmTWiH7PvbLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.544, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 5/19/23 05:00, Hao Xiang wrote:
> Hi,
> 
> After pulling in the QEMU latest commits, I can no longer run the 
> "configure" command. Below is the error message I am seeing. I believe 
> this is related to this change "configure: create a python venv 
> unconditionally".
> I am running on Debian GNU/Linux 11 (bullseye) and 5.15 kernel version.
> What can I do to fix/work around the issue?

Hi,

please try the patch I have Cc'd you on,

"[PATCH] mkvenv: replace distlib.database with importlib.metadata/pkg_resources"

Paolo


