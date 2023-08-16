Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD6177E312
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 15:53:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWGwl-0004do-VH; Wed, 16 Aug 2023 09:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWGwL-0004Os-B5
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 09:52:02 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWGwG-0004RH-SZ
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 09:51:59 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bdb801c667so42331835ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 06:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692193913; x=1692798713;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mZPCtM4gFlUO1eqBWQfyY/Y18ssOpc6HOYefevkB3hs=;
 b=E60lamU47sZQxI2mdxzaxIpzQ585cW73J6EcnIGUtt0mZ/TNXdyWMp2/dzxmLzyAfE
 Mu9LEylJIpAXxmDtu/izPvlfN/2tTaEfobzongnhiN/H75mF1tZM5KtcMx7wvcKqdGi6
 q22Oz6PXtIByw2bMo+CyND45GwR4JhJ74HXkvd2h5zmd7Py98uy4BGoGPVopqHtB8LSs
 AeH0zL/KiendIdwPw+xkOFfAHbOK7N/mIXRFAl63WX+dt3nS24h8J5RTTAORqtZfdL8r
 bZDS5s0hCOOkaMA5VCy1sdeKYT7TyloC8v5VknLg8AjYzAnMerp5cNFZ1K4wWw822ChR
 HS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692193913; x=1692798713;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mZPCtM4gFlUO1eqBWQfyY/Y18ssOpc6HOYefevkB3hs=;
 b=KTwkZuivGbcsPfbIenrLDCV78h6LBWugVRRQvn0WNUOCDubRyoO+1nBSRWh+95c2ib
 4K8qFmAFOAHttbbdBETucE4t7rwe+DRqYPFsp8Mr9OLSVUcmjZ0ZvjpURX5XYXMqWm7r
 o6tXTb7vwUgcKz0YN0yfS2iNxi/nznhfDeoed4QHJNjY7SvOa9Q8Lh8rGhmajjiMqIZw
 fKn86tPIGYDnngpafJTvsmn3TSiMr5eFT/VYsZX1ub99NVVELz7K8Z30rlkbGIOMNHIm
 Ua3tov5qjNqdivVhGkgGt/AVK2gGrvB7xRscej8FFm2kCz5Mpz/7k8ZhTbrx/ajHtX/E
 akhg==
X-Gm-Message-State: AOJu0YzOCg00pgGsgmNvpP2+Br6HjvWOHbN2JSaH1vh0+ZQ09yn2Eqb2
 E21yyu8chwp1zRJ3Lcto6KYiZA==
X-Google-Smtp-Source: AGHT+IF76m2gteYuU/ME8SyVTBxUSaRFmuZxrPHwMaaIRkLTBOKQwLw0o3YjJK7lICXb524S6ruUtA==
X-Received: by 2002:a17:902:bc89:b0:1bd:af7e:965d with SMTP id
 bb9-20020a170902bc8900b001bdaf7e965dmr2060152plb.51.1692193912914; 
 Wed, 16 Aug 2023 06:51:52 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 8-20020a17090a034800b00262e485156esm14092117pjf.57.2023.08.16.06.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 06:51:52 -0700 (PDT)
Message-ID: <b1b4843e-038c-43ac-8aa0-b95312b0806a@daynix.com>
Date: Wed, 16 Aug 2023 22:51:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/24] gdbstub: Simplify XML lookup
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Rolnik
 <mrolnik@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Laurent Vivier
 <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Stafford Horne <shorne@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
References: <20230731084354.115015-1-akihiko.odaki@daynix.com>
 <20230731084354.115015-13-akihiko.odaki@daynix.com>
 <87jztxrbv0.fsf@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87jztxrbv0.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2023/08/14 22:27, Alex Bennée wrote:
> 
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> Now we know all instances of GDBFeature that is used in CPU so we can
>> traverse them to find XML. This removes the need for a CPU-specific
>> lookup function for dynamic XMLs.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   gdbstub/gdbstub.c | 28 +++++++++-------------------
>>   1 file changed, 9 insertions(+), 19 deletions(-)
>>
>> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>> index 182efe7e0f..e5bb2c89ba 100644
>> --- a/gdbstub/gdbstub.c
>> +++ b/gdbstub/gdbstub.c
>> @@ -354,8 +354,7 @@ static const char *get_feature_xml(const char *p, const char **newp,
>>                                      GDBProcess *process)
>>   {
>>       size_t len;
>> -    int i;
>> -    const char *name;
>> +    GDBRegisterState *r;
>>       CPUState *cpu = gdb_get_first_cpu_in_process(process);
>>       CPUClass *cc = CPU_GET_CLASS(cpu);
>>   
>> @@ -364,15 +363,12 @@ static const char *get_feature_xml(const char *p, const char **newp,
>>           len++;
>>       *newp = p + len;
>>   
>> -    name = NULL;
>>       if (strncmp(p, "target.xml", len) == 0) {
>>           char *buf = process->target_xml;
>>           const size_t buf_sz = sizeof(process->target_xml);
>>   
>>           /* Generate the XML description for this CPU.  */
>>           if (!buf[0]) {
>> -            GDBRegisterState *r;
>> -
>>               pstrcat(buf, buf_sz,
>>                       "<?xml version=\"1.0\"?>"
>>                       "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">"
>> @@ -389,28 +385,22 @@ static const char *get_feature_xml(const char *p, const char **newp,
>>               pstrcat(buf, buf_sz, "\"/>");
>>               for (r = cpu->gdb_regs; r; r = r->next) {
>>                   pstrcat(buf, buf_sz, "<xi:include href=\"");
>> -                pstrcat(buf, buf_sz, r->feature->xml);
>> +                pstrcat(buf, buf_sz, r->feature->xmlname);
>>                   pstrcat(buf, buf_sz, "\"/>");
>>               }
>>               pstrcat(buf, buf_sz, "</target>");
>>           }
>>           return buf;
>>       }
> 
> It would be nice to modernise this code before adding to it. The static
> target_xml buffer and use of pstrcat could be replaced by GString code
> that is less sketchy.

I saw you did that yourself. Nevertheless I included my own 
implementation for the suggestion in v3. It uses 
g_markup_printf_escaped() for extra caution and better readability (i.e. 
the xi:include tags are written in a format: <xi:include href=\"%s\"/>).

> 
> 
>> -    if (cc->gdb_get_dynamic_xml) {
>> -        char *xmlname = g_strndup(p, len);
>> -        const char *xml = cc->gdb_get_dynamic_xml(cpu, xmlname);
>> -
>> -        g_free(xmlname);
>> -        if (xml) {
>> -            return xml;
>> -        }
>> +    if (strncmp(p, cc->gdb_core_feature->xmlname, len) == 0) {
>> +        return cc->gdb_core_feature->xml;
>>       }
>> -    for (i = 0; ; i++) {
>> -        name = gdb_features[i].xmlname;
>> -        if (!name || (strncmp(name, p, len) == 0 && strlen(name) == len))
>> -            break;
>> +    for (r = cpu->gdb_regs; r; r = r->next) {
>> +        if (strncmp(p, r->feature->xmlname, len) == 0) {
>> +            return r->feature->xml;
>> +        }
>>       }
>> -    return name ? gdb_features[i].xml : NULL;
>> +    return NULL;
>>   }
>>   
>>   const GDBFeature *gdb_find_static_feature(const char *xmlname)
> 
> 

