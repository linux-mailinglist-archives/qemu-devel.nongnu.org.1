Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3867B3291
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 14:31:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmCcV-00040y-Aq; Fri, 29 Sep 2023 08:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qmCcT-00040p-OR
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 08:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qmCcS-0003DA-5U
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 08:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695990558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/2+q/e3u4bEser6riESBsNdhaXlI2mHKhMjNRSbGUc=;
 b=KDSYFWXkjrojqnnN3EGehC3chv8nQSuA8bX8o4kjRjodB+4Bv7CZbs25Ya6NP+S2/ncysx
 TKNFlrpSVcPtRZykspOqX+xhjHU8AbKoh6qCIySuQlwHC2ROa+HdWkaPBFEdOvEoovEqAs
 p07y7HI/VVrfe3gN6iWBJ1ONKHQGcS4=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-0B5-dyroOQao9HtjdXti_Q-1; Fri, 29 Sep 2023 08:29:15 -0400
X-MC-Unique: 0B5-dyroOQao9HtjdXti_Q-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6c4e9d1a0aaso17548069a34.3
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 05:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695990555; x=1696595355;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b/2+q/e3u4bEser6riESBsNdhaXlI2mHKhMjNRSbGUc=;
 b=VGHV/L8cIZ2bNwkdkKvzzrlEmxdmfVa0+79Z1tZ1KN29wVJ/qXA9D0dqCX2XOuomgc
 Fl7yKZBbEr8o4h+NSxQY3fGdLhzd8UYzs/spsFCQ6hfqMRU2UThozsGic+6pics3cUpn
 FWXdS23/JOPGRWN8shf7XVEXFpi8xVIzMga/jako/pDbK57P1Se+aaQH2i+1Qwr2sA9C
 BNzhCltM10GhApPbLpUF8ClUtG+nByBcyHX0SJO7KndIGqZVDOv2dy13R+90/ALsy7gS
 YrjmrurF/B+RXQvyUXFx54jPmbdOhKIVuZxROrQ2RpZj3UJhyF+PqLswfedPE6Fx+jUL
 FFyg==
X-Gm-Message-State: AOJu0Yy/cUVt6VOS+nxY5NlRzk8E0cGAk86G84YJvj8Uh7T5w+WTZ8AS
 8tOKXvdmel5wjyI5TW07vBarRvTRoIekffRnrNsYcu1X4GKcTC3jOECswxoUrivX6GGRxC2HXCW
 41nRzu4PhNHeQNtE=
X-Received: by 2002:a9d:6210:0:b0:6bc:f636:153a with SMTP id
 g16-20020a9d6210000000b006bcf636153amr3926132otj.6.1695990555021; 
 Fri, 29 Sep 2023 05:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5ZCMWCwQXY7tyt/qJY4trT0LgNsQHPmGdOCFNH5P568Gxr8nuD1LAp1L9NF4j6lYkOZgfOw==
X-Received: by 2002:a9d:6210:0:b0:6bc:f636:153a with SMTP id
 g16-20020a9d6210000000b006bcf636153amr3926122otj.6.1695990554790; 
 Fri, 29 Sep 2023 05:29:14 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-123.web.vodafone.de.
 [109.43.177.123]) by smtp.gmail.com with ESMTPSA id
 u3-20020a0cf883000000b006616fbcc070sm191620qvn.122.2023.09.29.05.29.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 05:29:14 -0700 (PDT)
Message-ID: <734d189a-1068-a4c2-74b8-4a17346fdc47@redhat.com>
Date: Fri, 29 Sep 2023 14:29:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: MAINTAINERS still leaves more files uncovered than I'd like
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <87lecp6w7x.fsf@pond.sub.org> <87lecpuqui.fsf@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <87lecpuqui.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.295, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 29/09/2023 14.05, Cornelia Huck wrote:
> On Fri, Sep 29 2023, Markus Armbruster <armbru@redhat.com> wrote:
> 
>> Where are the remaining unmaintained files now?  Top-scoring
>> directories, files in sub-directories not counted:
>>
>>      $ sed 's,/[^/]*$,/,;s,^[^/]*$,./,' unmaintained-files | sort | uniq -c | sort -nr
>>
>>        # directory
> 
> (...)
> 
>>       40 include/standard-headers/linux/
> 
> Given that these are changed via update-linux-headers.sh, we should
> probably add
> 
> F: include/standard-headers/
> 
> to the Hosts/LINUX entry? (Some headers in standard-headers are covered
> in individual sections, but most are not.)

Sounds good, could you please send a patch?

  Thomas


