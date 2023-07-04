Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A6A746BA4
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:16:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbAy-0002eK-NC; Tue, 04 Jul 2023 04:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGbAw-0002do-GE
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGbAu-0002EP-Kv
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688458455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JhgpkslYsTYPl9qGRoxjjSfOJnK9ECqJwiO1AKSSzLk=;
 b=LpGhSlAvYGtmWjoJ3v8wLgvqqFnrE173aucYF2h30Do5spHr5VTjJ+64K4PVqTSZ+z35sW
 aAKXay5MqpDfMZH8AmH2s997CSOWqsQ+d3tJHvsojnEDJD1ts30md+oLvqLow0jt3P5HI4
 XPi4RFnAxEjBybxlv1fuNX/PEZzBE5c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-rYIdEcWCOe2Q4uvznlhEvA-1; Tue, 04 Jul 2023 04:14:14 -0400
X-MC-Unique: rYIdEcWCOe2Q4uvznlhEvA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31437f02985so1220717f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688458453; x=1691050453;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JhgpkslYsTYPl9qGRoxjjSfOJnK9ECqJwiO1AKSSzLk=;
 b=cImkhOhQyHepbiyz2/oERN02CUpHG25lPegNne+T8He9Hkegp11Ynt65AOgYkA2USQ
 mng5bK3wDSDZv2AEHGL5qOAjspdAE3LTDOBzGarEeF6UDSNmrvAYKRRjpKWP34+43nFx
 J99uLpIYQdZoPullhTGyrZCVd4hOo/d8N0O5ttsncgP79c6CmqFaphVkP45Jvpac+WLt
 aDwKaxOMQld3qoWf/Ba9BdPbME95gzw7RZNHkEYAVtMRhqcxe8Ffg3OEHljOsDEC5NjQ
 7HJS1+Kjgz61DD6AJPIVcMtR5HIDKT7z0/w7xpegWQncYRN0oRPPB6DA+DlONUc4/TrG
 +z3A==
X-Gm-Message-State: ABy/qLYMXGscRsJpb/lzn6WPFWRGSBLOjG8/ybRn4DICmhuO/CbC7z1P
 uiVgVXtSZtyMTMzzw9/SNMuz59ZqZfZYeLlwCzHDp3GJfNVHNCNodqqF5iIoAXVBGKjbFD2a0lD
 bFo4iWj7tnZhwEa0=
X-Received: by 2002:adf:cd02:0:b0:314:1b4d:bb27 with SMTP id
 w2-20020adfcd02000000b003141b4dbb27mr10633669wrm.64.1688458453239; 
 Tue, 04 Jul 2023 01:14:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGLryGDhKFGL8tSiJ/PMzcNYm0J49MK5ri9frOgTiv8qztYJqACE3O670v1qLFBBttSWOTmrg==
X-Received: by 2002:adf:cd02:0:b0:314:1b4d:bb27 with SMTP id
 w2-20020adfcd02000000b003141b4dbb27mr10633649wrm.64.1688458452858; 
 Tue, 04 Jul 2023 01:14:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2?
 (p200300d82f305a00b30de6bc74c3d6f2.dip0.t-ipconnect.de.
 [2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2])
 by smtp.gmail.com with ESMTPSA id
 d13-20020a5d4f8d000000b003063db8f45bsm27652314wru.23.2023.07.04.01.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 01:14:12 -0700 (PDT)
Message-ID: <8fbf7a94-8593-5811-fa93-2aa261095662@redhat.com>
Date: Tue, 4 Jul 2023 10:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 05/12] target/s390x: Fix LRA overwriting the top 32 bits
 on DAT error
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-stable@nongnu.org
References: <20230703155801.179167-1-iii@linux.ibm.com>
 <20230703155801.179167-6-iii@linux.ibm.com>
 <b105761d-9602-030a-e578-12d9cd0a0283@redhat.com>
 <e893b9be6e71946120f6e54422814f7d4219f484.camel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <e893b9be6e71946120f6e54422814f7d4219f484.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

>>
>>>        } else {
>>>            cc = 0;
>>>            ret |= addr & ~TARGET_PAGE_MASK;
>>> diff --git a/target/s390x/tcg/translate.c
>>> b/target/s390x/tcg/translate.c
>>> index 0cef6efbef4..a6079ab7b4f 100644
>>> --- a/target/s390x/tcg/translate.c
>>> +++ b/target/s390x/tcg/translate.c
>>> @@ -2932,7 +2932,7 @@ static DisasJumpType op_lctlg(DisasContext
>>> *s, DisasOps *o)
>>>    
>>>    static DisasJumpType op_lra(DisasContext *s, DisasOps *o)
>>>    {
>>> -    gen_helper_lra(o->out, cpu_env, o->in2);
>>> +    gen_helper_lra(o->out, cpu_env, o->out, o->in2);
>>>        set_cc_static(s);
>>>        return DISAS_NEXT;
>>>    }
>>
>> Can't we use something like in1_r1 + wout_r1_32 instead ? *maybe*
>> cleaner :)
>>
> 
> The problem is that we want all 64 bits for the non-error case.
> 

Ah, I missed that detail, thanks.

-- 
Cheers,

David / dhildenb


