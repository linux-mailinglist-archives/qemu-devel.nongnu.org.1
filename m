Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9633D78749C
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:53:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCdk-0008Pp-2A; Thu, 24 Aug 2023 11:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qZCdi-0008Ph-BA
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qZCdg-0007Zr-1m
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692892370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lMJ/nHEfe44zcHDj9W6iEufWesC20Xci0HL1dBY9/fI=;
 b=jLRrEaox1TzAuIXPxssRsc32ddDzTpY77rKTdeuCiDeNbJg74OTWBKrPQIBvs/cXek6Y2/
 ne5a/Jfgu6Z/gtauIEvRl2VNnRH6VeAPxKYCh5iJuzeO/jQ6nu5xMSR+FjjvylBhfautnf
 fCloklgvesttDKERdkIE8QytKV4Jgxk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-fvxi7jBiN72bolmJDnAMAQ-1; Thu, 24 Aug 2023 11:52:48 -0400
X-MC-Unique: fvxi7jBiN72bolmJDnAMAQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4005f0a53c5so12626735e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 08:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692892364; x=1693497164;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lMJ/nHEfe44zcHDj9W6iEufWesC20Xci0HL1dBY9/fI=;
 b=HB0okwVRBJieAuFQHUWpqb055DY46HUgADVP8feOK7uMbSZN18KyFZk7B4n+bUkWiH
 aHj1hGqBTd7LhT0l8PeC9XWOoYeQWQcxwF5R7Q0ia/VRaf28wN4leXvFpRuPAqCeVrQr
 rhCnTYu9nme4FiLtgjTYY1p8+vNWby7Z3JRFy+Zxsehb7f5kWTLHGmOov+JrqBEihe5T
 d9UxRq+VEiG4YzM3F4EsOMQUvFPFIVRprTc8Bv7FCOElapudAbJYYU/Yu/kfsBMSibBu
 XLzA9bsGV3yhbIbPZzogQykqeCVw43iwMR8bknWICAZeBkYuVqbWdyyi1A6NrH11ocs9
 9+zQ==
X-Gm-Message-State: AOJu0YxyvyfWFMS5Pcf+DmI515h07FuxEcQPIrillIKTQ0inP1giT5Qt
 rQnRLSKAH9vgKg4j9/ggX4+MshMAta3z+pm2kp/rC5acq2ShTgmDLBJrrhFUMfADFZqhN2ZpkZa
 gBUwsUptxU7srYuI=
X-Received: by 2002:a7b:c051:0:b0:3fc:616:b0db with SMTP id
 u17-20020a7bc051000000b003fc0616b0dbmr12232408wmc.9.1692892364090; 
 Thu, 24 Aug 2023 08:52:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErFrTmTI3Bmr/aHjIx8opetjLs4W5wR1IlUgQMpK3CVAp/zNAJNNKUVDKpayUhoP5VvKQYTg==
X-Received: by 2002:a7b:c051:0:b0:3fc:616:b0db with SMTP id
 u17-20020a7bc051000000b003fc0616b0dbmr12232394wmc.9.1692892363665; 
 Thu, 24 Aug 2023 08:52:43 -0700 (PDT)
Received: from [192.168.8.103] (tmo-099-164.customers.d1-online.com.
 [80.187.99.164]) by smtp.gmail.com with ESMTPSA id
 g18-20020a5d5552000000b003142ea7a661sm22549018wrw.21.2023.08.24.08.52.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 08:52:42 -0700 (PDT)
Message-ID: <4b20edf5-d4d9-2bd1-2884-39d13dd3827d@redhat.com>
Date: Thu, 24 Aug 2023 17:52:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [POC 2/2] add test exposing AHCI reset issue
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, pbonzini@redhat.com, srowe@mose.org.uk,
 mike.maslenkin@gmail.com, qemu-block@nongnu.org, t.lamprecht@proxmox.com,
 a.lauterer@proxmox.com
References: <20230824133831.617833-1-f.ebner@proxmox.com>
 <20230824133831.617833-2-f.ebner@proxmox.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230824133831.617833-2-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.919, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 24/08/2023 15.38, Fiona Ebner wrote:
> Fails without the previous commit "hw/ide: reset: cancel async DMA
> operation before reseting state".
> 
> I haven't ever written such a test before, but I wanted something to
> expose the problem more easily. It hardcodes the behavior that the
> pending write actually is done during reset, which might not be ideal.
> It could just check that the first sector is still intact instead.
> 
> If I should make this a proper test, I'd be happy about some guidance,
> but not sure if required for such a specific one-off issue. After all,
> a different variation of the bug might have written to some other
> sector not covered by this test.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   tests/qtest/ahci-test.c | 81 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 81 insertions(+)
> 
> diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
> index abab761c26..3ebeb4e255 100644
> --- a/tests/qtest/ahci-test.c
> +++ b/tests/qtest/ahci-test.c
> @@ -1401,6 +1401,84 @@ static void test_max(void)
>       ahci_shutdown(ahci);
>   }
>   
> +static void test_reset_with_pending_callback(void)
> +{
> +    AHCIQState *ahci;
> +
> +    ahci = ahci_boot(NULL);
> +    ahci_test_pci_spec(ahci);
> +    ahci_pci_enable(ahci);
> +
> +    int bufsize = 512 * 1024;
> +    int offset1 = 0;
> +    int offset2 = bufsize / AHCI_SECTOR_SIZE;
> +
> +    ahci_test_hba_spec(ahci);
> +    ahci_hba_enable(ahci);
> +    ahci_test_identify(ahci);
> +
> +    uint8_t port = ahci_port_select(ahci);
> +    ahci_port_clear(ahci, port);
> +
> +    unsigned char *tx1 = g_malloc(bufsize);
> +    unsigned char *tx2 = g_malloc(bufsize);
> +    unsigned char *rx1 = g_malloc0(bufsize);
> +    unsigned char *rx2 = g_malloc0(bufsize);
> +    uint64_t ptr1 = ahci_alloc(ahci, bufsize);
> +    uint64_t ptr2 = ahci_alloc(ahci, bufsize);

As Philippe already mentioned, please declare variables at the beginning of 
the functions to match our coding style.

I'd also oike to suggest to use g_autofree for the buffers that you 
malloced, so you can drop the g_frees at the end of the function.

> +    g_assert(ptr1 && ptr2);
> +
> +    /* Need two different patterns. */
> +    do {
> +        generate_pattern(tx1, bufsize, AHCI_SECTOR_SIZE);
> +        generate_pattern(tx2, bufsize, AHCI_SECTOR_SIZE);
> +    } while (memcmp(tx1, tx2, bufsize) == 0);
> +
> +    qtest_bufwrite(ahci->parent->qts, ptr1, tx1, bufsize);
> +    qtest_bufwrite(ahci->parent->qts, ptr2, tx2, bufsize);
> +
> +    /* Write to beginning of disk to check it wasn't overwritten later. */
> +    ahci_guest_io(ahci, port, CMD_WRITE_DMA_EXT, ptr1, bufsize, offset1);
> +
> +    /* Issue asynchronously to get a pending callback during reset. */
> +    AHCICommand *cmd = ahci_command_create(CMD_WRITE_DMA_EXT);
> +    ahci_command_adjust(cmd, offset2, ptr2, bufsize, 0);
> +    ahci_command_commit(ahci, cmd, port);
> +    ahci_command_issue_async(ahci, cmd);
> +
> +    ahci_set(ahci, AHCI_GHC, AHCI_GHC_HR);
> +
> +    ahci_command_free(cmd);
> +
> +    /* Start again. */
> +    ahci_clean_mem(ahci);
> +    ahci_pci_enable(ahci);
> +    ahci_hba_enable(ahci);
> +    port = ahci_port_select(ahci);
> +    ahci_port_clear(ahci, port);
> +
> +    /* Read and verify. */
> +    ahci_guest_io(ahci, port, CMD_READ_DMA_EXT, ptr1, bufsize, offset1);
> +    qtest_bufread(ahci->parent->qts, ptr1, rx1, bufsize);
> +    g_assert_cmphex(memcmp(tx1, rx1, bufsize), ==, 0);
> +
> +    ahci_guest_io(ahci, port, CMD_READ_DMA_EXT, ptr2, bufsize, offset2);
> +    qtest_bufread(ahci->parent->qts, ptr2, rx2, bufsize);
> +    g_assert_cmphex(memcmp(tx2, rx2, bufsize), ==, 0);
> +
> +    ahci_free(ahci, ptr1);
> +    ahci_free(ahci, ptr2);
> +    g_free(tx1);
> +    g_free(tx2);
> +    g_free(rx1);
> +    g_free(rx2);
> +
> +    ahci_clean_mem(ahci);
> +
> +    ahci_shutdown(ahci);
> +}
> +
>   static void test_reset(void)
>   {
>       AHCIQState *ahci;
> @@ -1915,6 +1993,9 @@ int main(int argc, char **argv)
>       g_assert(fd >= 0);
>       close(fd);
>   
> +    qtest_add_func("/ahci/reset_with_pending_callback",
> +                   test_reset_with_pending_callback);

It would make more sense to put this below the "Run the tests" comment below.

>       /* Run the tests */
>       qtest_add_func("/ahci/sanity",     test_sanity);
>       qtest_add_func("/ahci/pci_spec",   test_pci_spec);

  Thomas


