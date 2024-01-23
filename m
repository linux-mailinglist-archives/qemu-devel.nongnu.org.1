Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DA083870E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 07:03:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS9r4-0003MF-Pu; Tue, 23 Jan 2024 01:01:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rS9r2-0003Lj-Ry
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 01:01:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rS9r1-00020Z-7B
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 01:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705989706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8b1APuGuolgG2iDO4VcLt6TOCUmnLraDN2Px29rMzJg=;
 b=GdAwtO6dEBR+FwXdQKKh+FaBBSsCnGzU5sPmuhbvU5Yy10CeVhtJ7iUv52SMD2DXIVnxSC
 Yw2Fq5zXpK+DhDSaikMq0mM/p+UE2HA4IafEs3htuLht0E/2wYVscYNw7LEIQHejcNmDNg
 lMaZWYynsAPwEm0/F/boznvTmyNVSRY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-3oBJ7vLCPwm3nE9lJwQIOQ-1; Tue, 23 Jan 2024 01:01:44 -0500
X-MC-Unique: 3oBJ7vLCPwm3nE9lJwQIOQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50e5aa11579so3525119e87.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 22:01:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705989703; x=1706594503;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8b1APuGuolgG2iDO4VcLt6TOCUmnLraDN2Px29rMzJg=;
 b=Gzgmb5bo6TdCEJ7GI9G+l993VLhGlOm9BSg5/qttwnJ5AmnGErILTes5b40KExgHIZ
 mZIHKx2kA15JJZhj31qPL41TuzT6J+Zp9qLlvCmgPYwV/+9qeSZRwC86N9UO6yfPP28X
 LR7Wgn0PRKPNPW2wj7Pk/mQAML/7qGqsM8vnzTjsG9BHwXgyj38KLrJRTbb+isJfQ19T
 0A/29Kj16NybZJwuPt5+PMQTJH08vK9kCTaORF+en91rWkhNyO/uFAChgcBtl7dJWtt4
 9L0IoIFAkc1OpC1cxD4JV/ZFQjCPr0VGaE4UZh+G7MKuL0cZAwX6kR1jblaFiz1wjHbb
 zxGQ==
X-Gm-Message-State: AOJu0YzqZA4d2e26CStyjUe7N8QwUy5nxMPY2kozq8YOZ+d7ThSmfm0k
 m28uNMTYAuAck4o3ta1G2twE7Yic1memTkGp3xSVq3tGxPXRHfVsRKXUFoBw5uWITJK78shI4ar
 JLqxeJ2OP0A8joLSo6UDV6d4z20Vg6HJOgSAs5ekj8GAJmVxpI5Aw
X-Received: by 2002:a05:6512:3f05:b0:50e:e168:9fcd with SMTP id
 y5-20020a0565123f0500b0050ee1689fcdmr2697849lfa.26.1705989702804; 
 Mon, 22 Jan 2024 22:01:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYGQKDWYF4mY8F6uWMDXFaV+9pZYFEWOmxGhQfg+ct6egYC/b4itvmLmgGr5jx0OUeAc4yUQ==
X-Received: by 2002:a05:6512:3f05:b0:50e:e168:9fcd with SMTP id
 y5-20020a0565123f0500b0050ee1689fcdmr2697842lfa.26.1705989702485; 
 Mon, 22 Jan 2024 22:01:42 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-121.web.vodafone.de.
 [109.43.177.121]) by smtp.gmail.com with ESMTPSA id
 th7-20020a1709078e0700b00a2fd84bc421sm3232512ejc.83.2024.01.22.22.01.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 22:01:42 -0800 (PST)
Message-ID: <f4062f9b-617a-4ea9-90f1-b9b5eee20523@redhat.com>
Date: Tue, 23 Jan 2024 07:01:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] util/uri: Simplify uri_string_unescape()
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-trivial@nongnu.org
References: <20240122191753.103118-1-thuth@redhat.com>
 <20240122191753.103118-3-thuth@redhat.com>
 <8c728584-8bf2-4122-bc2b-a8063d89fbe8@weilnetz.de>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <8c728584-8bf2-4122-bc2b-a8063d89fbe8@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 22/01/2024 22.22, Stefan Weil wrote:
> Am 22.01.24 um 20:17 schrieb Thomas Huth:
> 
>> uri_string_unescape() basically does the same as the glib function
>> g_uri_unescape_string(), with just an additional length parameter.
>> So we can simplify this function a lot by limiting the length with
>> g_strndup() first and then by calling g_uri_unescape_string() instead
>> of walking through the string manually.
>>
>> Suggested-by: Stefan Weil<stefan.weil@weilnetz.de>
> 
> Can my e-mail address be replaced by another one (sw@weilnetz.de)?

Sure! ... not sure where I copy-n-pasted the other one from ... sorry for that.

>> @@ -1585,8 +1576,7 @@ static int is_hex(char c)
>>    */
>>   char *uri_string_unescape(const char *str, int len)
>>   {
>> -    char *ret, *out;
>> -    const char *in;
>> +    g_autofree char *lstr = NULL;
> 
> 
> Is it necessary to assign NULL? It does not look so.

Yes, it's necessary for the early "return NULL" statement below. Since it's 
an g_autofree variable, it must either be set to a valid allocated buffer or 
NULL before returning.

>>   
>>       if (str == NULL) {
>>           return NULL;
>> @@ -1594,42 +1584,9 @@ char *uri_string_unescape(const char *str, int len)
>>       if (len <= 0) {
>>           len = strlen(str);
>>       }
>> -    if (len < 0) {
>> -        return NULL;
>> -    }
>> -
>> -    ret = g_malloc(len + 1);
>> +    lstr = g_strndup(str, len);
>>   
>> -    in = str;
>> -    out = ret;
>> -    while (len > 0) {
>> -        if ((len > 2) && (*in == '%') && (is_hex(in[1])) && (is_hex(in[2]))) {
>> -            in++;
>> -            if ((*in >= '0') && (*in <= '9')) {
>> -                *out = (*in - '0');
>> -            } else if ((*in >= 'a') && (*in <= 'f')) {
>> -                *out = (*in - 'a') + 10;
>> -            } else if ((*in >= 'A') && (*in <= 'F')) {
>> -                *out = (*in - 'A') + 10;
>> -            }
>> -            in++;
>> -            if ((*in >= '0') && (*in <= '9')) {
>> -                *out = *out * 16 + (*in - '0');
>> -            } else if ((*in >= 'a') && (*in <= 'f')) {
>> -                *out = *out * 16 + (*in - 'a') + 10;
>> -            } else if ((*in >= 'A') && (*in <= 'F')) {
>> -                *out = *out * 16 + (*in - 'A') + 10;
>> -            }
>> -            in++;
>> -            len -= 3;
>> -            out++;
>> -        } else {
>> -            *out++ = *in++;
>> -            len--;
>> -        }
>> -    }
>> -    *out = 0;
>> -    return ret;
>> +    return g_uri_unescape_string(lstr, NULL);
>>   }
>>   
>>   /**
> 
> 
> Thank you.
> 
> Reviewed-by: Stefan Weil <sw@weilnetz.de>

Thanks!

  Thomas



