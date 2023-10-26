Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 289E17D83AF
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 15:35:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw0Uz-0001jD-R8; Thu, 26 Oct 2023 09:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qw0Ux-0001ih-EP
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 09:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qw0Uv-0001u4-Ou
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 09:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698327244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDflrNT8L0T++0OyNXNRbDI9hIsT4WQqlci3T25+M0I=;
 b=TogLxJw7BMIZFQLPk41RMpfihIWOo5B9bSNZWLrHJt/dR/vqNxV5bDNBlc+ncgiDYHF39i
 GfByhwSDPzvJbtzpZejOanjfr5UbWWgwlOy535YscrGY9O4SdEZRnZhfEQMOVhAJVEvtSB
 WFtbvOyeNyDw0Mx1d7gpGmCurTw8gFI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-pIfI_NqlMrCyBXx1TbtUUg-1; Thu, 26 Oct 2023 09:33:46 -0400
X-MC-Unique: pIfI_NqlMrCyBXx1TbtUUg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7788fa5f13cso126613685a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 06:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698327226; x=1698932026;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iDflrNT8L0T++0OyNXNRbDI9hIsT4WQqlci3T25+M0I=;
 b=BCYlgNCWnhtd8/9OkqKAdq9uWxOEfDRR5e65q3ie2WsJIFTw6GK0qKY6bfcIBLxFti
 cEAe+u9DwiCgorYFtgpzNxDNM1E4YTdrkLlK/4mYAu1zorp5AZNIwi6rcUZp/U4sxdB5
 td88nAgXcFt0reTtDM9XTvWxrgvGSCCfXxYlIMtGeiS1ML8+NitgA9CRCKhUz5ftwbMu
 Jre0Ve/JpjcLP52mFiinqCQu4r/45PUsXEXkVXxZPPGiLvH8SQ5T7/Db1RKK5T7sQ0Mm
 /w0F+H3ahOvuHpHU2Xu5YQ4aG+cCnHZ7roKrxlaO3JpzNtwOCDjETVUdAYIHKISbKrJl
 1kAA==
X-Gm-Message-State: AOJu0YxDagclRQGXWl1CHiomOqGRrVbu7NrJIV0Q8BG/YTz9clkgvtJ6
 3y5SDoiuFoCauV7TuDzacvgM9VZGWmVWMEmq5VuBopqQeYBwJNm13tNquMgcEqKzWX0vv/Bf4c6
 dDXu0Q7p/AFZRF3Y=
X-Received: by 2002:a05:620a:28c2:b0:76f:b00:4e66 with SMTP id
 l2-20020a05620a28c200b0076f0b004e66mr3370315qkp.9.1698327226345; 
 Thu, 26 Oct 2023 06:33:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG89j4CKh88+JuKoVRc4s/TzJ8HPGI5pkxYKfBVreZKyZpIFcqj7dOqkOBTbpAW7wJblS30DA==
X-Received: by 2002:a05:620a:28c2:b0:76f:b00:4e66 with SMTP id
 l2-20020a05620a28c200b0076f0b004e66mr3370296qkp.9.1698327226105; 
 Thu, 26 Oct 2023 06:33:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 qs21-20020a05620a395500b007671cfe8a18sm5001634qkn.13.2023.10.26.06.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 06:33:45 -0700 (PDT)
Message-ID: <25e63d15-1921-4e09-9adc-3d4cd1e77f91@redhat.com>
Date: Thu, 26 Oct 2023 15:33:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] vfio/pci: Fix buffer overrun when writing the VF
 token
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20231026070636.1165037-1-clg@redhat.com>
 <20231026070636.1165037-3-clg@redhat.com>
 <CAFEAcA9jbb6MYOC8DHaPEiQsq9BZoLhfk7-vfOM1Gmi0amEM4g@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <CAFEAcA9jbb6MYOC8DHaPEiQsq9BZoLhfk7-vfOM1Gmi0amEM4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 10/26/23 13:28, Peter Maydell wrote:
> On Thu, 26 Oct 2023 at 08:08, Cédric Le Goater <clg@redhat.com> wrote:
>>
>> qemu_uuid_unparse() includes a trailing NUL when writing the uuid
>> string and the buffer size should be UUID_FMT_LEN + 1 bytes. Use the
>> recently added UUID_STR_LEN which defines the correct size.
>>
>> Fixes: CID 1522913
>> Fixes: 2dca1b37a760 ("vfio/pci: add support for VF token")
>> Cc: Alex Williamson <alex.williamson@redhat.com>
>> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/pci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 9bfa83aca1a87952e18743c9ca951b1bfc873507..c02a5d70f5e1b8e4d22051285748f514f1b9f008 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3274,7 +3274,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>       Error *err = NULL;
>>       int i, ret;
>>       bool is_mdev;
>> -    char uuid[UUID_FMT_LEN];
>> +    char uuid[UUID_STR_LEN];
>>       char *name;
>>
>>       if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
> 
> This patch (and its dependency) should probably be cc qemu-stable ?

yes. 8.1 is impacted. I was waiting for some feedback.

Thanks,

C.


